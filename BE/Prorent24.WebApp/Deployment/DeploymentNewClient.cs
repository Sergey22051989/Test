using Prorent24.Common.ApplicationSettings;
using Prorent24.Context;
using System;
using System.IO;

namespace Prorent24.WebApp.Deployment
{
    /// <summary>
    /// 
    /// </summary>
    public static class DeploymentNewClient
    {
        /// <summary>
        /// 
        /// </summary>
        public static void Deploy(Prorent24DbContext context, string connectionString, string evirement)
        {
            //Create MAIN DB
            CreateDataBase(context, connectionString, evirement);

            //Create LOG DB
            CreateLOGDataBase(evirement);
        }

        /// <summary>
        /// Create directories for client
        /// </summary>
        public static void CreateDirectories()
        {
            //Add new file directory if not exists 
            if (!Directory.Exists(DirectorySettings.fileDirectory))
            {
                Directory.CreateDirectory(DirectorySettings.fileDirectory);
            }

            //Add new backup directory if not exists
            if (!Directory.Exists(DirectorySettings.backupDirectory))
            {
                Directory.CreateDirectory(DirectorySettings.backupDirectory);
            }

            //Add new backup directory if not exists
            if (!Directory.Exists(DirectorySettings.logsDirectory))
            {
                Directory.CreateDirectory(DirectorySettings.logsDirectory);
            }

            //Add new dataBase directory if not exists
            if (!File.Exists(DirectorySettings.dataBasesDirectory))
            {
                Directory.CreateDirectory(DirectorySettings.dataBasesDirectory);
            }

            //Add new reports directory if not exists
            if (!File.Exists(DirectorySettings.reportDirectory))
            {
                Directory.CreateDirectory(DirectorySettings.reportDirectory);
            }
        }

        private static void CreateLOGDataBase(string evirement)
        {
            string pathToCarrentDb = string.Concat(DirectorySettings.logsDirectory, evirement, ".db");

            if (!File.Exists(pathToCarrentDb))
            {
                File.Create(pathToCarrentDb);
            }
        }

            private static void CreateDataBase(Prorent24DbContext context, string connectionString, string evirement)
            {
                if (evirement != "Development")
                {
                    string pathToCarrentDb = string.Concat(DirectorySettings.dataBasesDirectory, evirement, ".db");

                    if (!File.Exists(pathToCarrentDb))
                    {
                        File.Copy(DirectorySettings.dataBaseEmptyPath, pathToCarrentDb);
                    }
                    else
                    {
                        string backupDataBasePath = string.Concat(DirectorySettings.backupDirectory, DateTime.Now.Date.ToString("yyyy_MM_dd"), ".db");

                        if (File.Exists(backupDataBasePath))
                        {
                            File.Delete(backupDataBasePath);
                        }

                        File.Copy(pathToCarrentDb, backupDataBasePath);
                    }
                }
            }

        }
    }
