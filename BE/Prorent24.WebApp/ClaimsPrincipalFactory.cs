using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Prorent24.Entity;
using System;
using System.IO;
using System.Security.Claims;
using System.Threading.Tasks;

namespace Prorent24.WebApp
{
    /// <summary>
    /// Extension Identity user
    /// </summary>
    public class ClaimsPrincipalFactory : UserClaimsPrincipalFactory<User, Role>
    {
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="userManager"></param>
        /// <param name="roleManager"></param>
        /// <param name="optionsAccessor"></param>
        public ClaimsPrincipalFactory(
        UserManager<User> userManager,
        RoleManager<Role> roleManager,
        IOptions<IdentityOptions> optionsAccessor) : base(userManager, roleManager, optionsAccessor)
        {
        }

        /// <summary>
        /// Create claims
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public async override Task<ClaimsPrincipal> CreateAsync(User user)
        {
            var principal = await base.CreateAsync(user);

            if (!string.IsNullOrWhiteSpace(user.FirstName))
            {
                ((ClaimsIdentity)principal.Identity).AddClaims(new[] { new Claim(ClaimTypes.GivenName, user.FirstName) });
            }

            if (!string.IsNullOrWhiteSpace(user.LastName))
            {
                ((ClaimsIdentity)principal.Identity).AddClaims(new[] { new Claim(ClaimTypes.Surname, user.LastName) });
            }

            if (!string.IsNullOrWhiteSpace(user.ProfileImage))
            {
                 ((ClaimsIdentity)principal.Identity).AddClaims(new[] { new Claim(ClaimTypes.Anonymous, user.ProfileImage) });

            }

            return principal;
        }
    }
}
