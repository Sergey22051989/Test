using Microsoft.EntityFrameworkCore;
using Prorent24.Common.ApplicationSettings;
using Prorent24.Context;
using System;
using System.IO;
using System.Linq;

namespace Prorent24.WebApp.Deployment
{
    internal static class PostDeployment
    {
        internal static void ExecutePostDeployment(this Prorent24DbContext context, string connectionString, string envirement)
        {
            //Deployment new client
            DeploymentNewClient.Deploy(context, connectionString, envirement);

            //Update Empty dataBase
            UpdateDatabase.ExecuteUpdate(DirectorySettings.scriptDirectory, DirectorySettings.connStringToEmptyDb);

            //Update current dataBase
            UpdateDatabase.ExecuteUpdate(DirectorySettings.scriptDirectory, connectionString);

            #region UPDATE DATA

            var vatClasses = context.VatClasses.Include(x=>x.VatClassSchemeRates).ToList();
            vatClasses.ForEach(x =>
            {
                if(x.Name.Equals("Нулевая ставка"))
                {
                    x.Name = "НДС 0%";
                }
                else if (x.Name.Equals("Низкая ставка"))
                {
                    x.Name = "НДС 10%";
                    x.VatClassSchemeRates.Where(c => c.VatClassId == x.Id).ToList().ForEach(v =>
                    {
                        v.Rate = 10;
                    });
                }
                else if (x.Name.Equals("Высокая ставка"))
                {
                    x.Name = "НДС 15%";
                    x.VatClassSchemeRates.Where(c => c.VatClassId == x.Id).ToList().ForEach(v =>
                    {
                        v.Rate = 15;
                    });
                }
            });

            context.VatClasses.UpdateRange(vatClasses);
            context.SaveChanges();

            #endregion
        }

        //Write new structure to structures directory
        internal static void WriteStructureToFile(this Prorent24DbContext context)
        {
            string migrationId = context.Database.GetMigrations().LastOrDefault();

            if (!string.IsNullOrWhiteSpace(migrationId))
            {
                string scriptDb = context.Database.GenerateCreateScript();
                string structurePath = string.Concat(DirectorySettings.appDataDirectory, "Structures\\", migrationId, ".sql");

                if (File.Exists(structurePath))
                {
                    File.Delete(structurePath);
                }

                File.WriteAllText(structurePath, scriptDb);
            }
            else
            {
                throw new Exception();
            }
        }

    }
}
