using Prorent24.Common.ApplicationSettings;

namespace Prorent24.WebApp.Deployment
{
    /// <summary>
    /// 
    /// </summary>
    public static class ConfigurationSettings
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="envirement"></param>
        public static void Configure(string envirement)
        {
            DirectorySettings.fileDirectory = string.Concat(DirectorySettings.fileDirectory, envirement);
            DirectorySettings.backupDirectory = string.Concat(DirectorySettings.backupDirectory, envirement);
            DirectorySettings.logsDirectory = string.Concat(DirectorySettings.backupDirectory, envirement);
            DirectorySettings.reportDirectory = string.Concat(DirectorySettings.reportDirectory, envirement);

            if(envirement == "Development")
            {
                DirectorySettings.frontEnvDirectory = string.Concat(DirectorySettings.currentDirectory, "\\", DirectorySettings.frontEnvDevDirectory);
            }
            else
            {
                DirectorySettings.frontEnvDirectory = string.Concat(DirectorySettings.currentDirectory,"\\", DirectorySettings.frontEnvProdDirectory);
            }

            DirectorySettings.frontPathToI18n = string.Concat(DirectorySettings.frontEnvDirectory, DirectorySettings.frontPathToI18n);
        }
    }
}
