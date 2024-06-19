using Dapper;
using Microsoft.Data.Sqlite;
using Prorent24.Common.ApplicationSettings;
using Prorent24.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;

namespace Prorent24.WebApp.Deployment
{
    internal static class UpdateDatabase
    {

        /// <summary>
        /// Added files for execute scripts
        /// </summary>
        /// <param name="pathDiractoryScripts"></param>
        /// <param name="connectionString"></param>
        private static void AddScriptsForExecute(string connectionString, string pathDiractoryScripts)
        {
            using (IDbConnection db = new SqliteConnection(connectionString))
            {
                try
                {
                    var exists = db.QuerySingleOrDefault<bool>("SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = 'sys_migration_database'");

                    if (!exists)
                    {
                        db.Execute(File.ReadAllText(string.Concat(pathDiractoryScripts, "AdditionalScripts\\CreateTable_MigrationDataBase.sql")));
                    }

                    string[] scriptsPath = Directory.GetFiles(pathDiractoryScripts);

                    for (int i = 0; i < scriptsPath.Length; i++)
                    {
                        FileInfo scriptInfo = new FileInfo(scriptsPath[i]);

                        if (scriptInfo.Name != "Script.sql")
                        {
                            var countRows = db.QuerySingle<int>("SELECT COUNT(Id) FROM sys_migration_database WHERE [MigrationName] == @MigrationName", new { MigrationName = scriptInfo.Name });

                            if (countRows < 1)
                            {
                                db.Execute(@"INSERT INTO sys_migration_database 
                                ( 
                                    [MigrationName], 
                                    [MigrationData],
                                    [Executed]
                                )
                                VALUES
                                (
                                    @MigrationName,
                                    @MigrationData,
                                    @Executed
                                )", new
                                {
                                    MigrationName = scriptInfo.Name,
                                    MigrationData = File.ReadAllText(scriptsPath[i]),
                                    Executed = false
                                });
                            }
                            else
                            {
                                db.Execute("UPDATE sys_migration_database SET [MigrationData] = @MigrationData WHERE [MigrationName] == @MigrationName", new { MigrationName = scriptInfo.Name, MigrationData = File.ReadAllText(scriptsPath[i]) });
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw;
                }
            }
        }

        /// <summary>
        /// Executed Scripts
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="pathScripts"></param>
        /// <param name="migarionDataBase"></param>
        /// <param name="isError"></param>
        /// <param name="message"></param>
        private static void ExecutedScript(string connectionString, MigarionDataBase migarionDataBase,bool isError,string message)
        {
            string directoryReports = string.Concat(DirectorySettings.reportDirectory, "\\");
            string directoryReportsNowDate = string.Concat(directoryReports, DateTime.Now.Date.ToString("dd_MM_yyyy"));
            string scriptPathError = string.Concat(directoryReportsNowDate, "\\ERROR_", migarionDataBase.MigrationName.Replace("sql", "txt"));
            string scriptPathSuccess = string.Concat(directoryReportsNowDate, "\\SUCCESS_", migarionDataBase.MigrationName.Replace("sql", "txt"));

            if (!Directory.Exists(directoryReportsNowDate))
            {
                Directory.CreateDirectory(directoryReportsNowDate);
            }

            if (!isError)
            {
                using (IDbConnection db = new SqliteConnection(connectionString))
                {
                    db.Execute("UPDATE sys_migration_database SET [Executed] = 1 WHERE [Id] == @Id", new { Id = migarionDataBase.Id });
                }

                File.Delete(scriptPathError);
                File.WriteAllText(scriptPathSuccess, message);
            }
            else
            {
                File.Delete(scriptPathSuccess);
                File.WriteAllText(scriptPathError, message);
            }

            
        }

        /// <summary>
        /// Execute update data base from migration script
        /// </summary>
        /// <param name="pathScripts"></param>
        /// <param name="connectionString"></param>
        internal static void ExecuteUpdate(string pathScripts, string connectionString)
        {
            //Added new data for execute scripts
            AddScriptsForExecute(connectionString, pathScripts);

            using (IDbConnection db = new SqliteConnection(connectionString))
            {
                List<MigarionDataBase> migrations = db.Query<MigarionDataBase>("SELECT * FROM sys_migration_database WHERE [Executed] == 0").AsList();

                foreach (MigarionDataBase item in migrations)
                {
                    try
                    {
                        db.Execute(item.MigrationData);
                        ExecutedScript(connectionString, item, false, item.MigrationData);
                    }
                    catch (Exception ex)
                    {
                        bool isError = true;

                        if(ex.Message.Contains("duplicate column name"))
                        {
                            isError = false;
                        }

                        ExecutedScript(connectionString, item, isError, ex.Message);
                    }
                }

            }
        }
    }
}
