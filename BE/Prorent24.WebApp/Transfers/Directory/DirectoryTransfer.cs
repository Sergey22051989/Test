using Prorent24.BLL.Models.Directory;
using Prorent24.WebApp.Models.Directory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Prorent24.WebApp.Transfers.Directory
{
    public static class DirectoryTransfer
    {
        public static List<DirectoryViewModel> TransferToViewModels(this List<DirectoryDto> dtos)
        {
            return dtos.Select(x => x.TransferToViewModel()).ToList();
        }

        /// <summary>
        /// Transfer from DirectoryDto to DirectoryViewModel
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        /// 
        public static DirectoryViewModel TransferToViewModel(this DirectoryDto dto)
        {
            DirectoryViewModel viewModel = new DirectoryViewModel()
            {
                Id = dto.Id,
                IsActive = dto.IsActive,
                Type = dto.Type,
                ParentId = dto.ParentId,
                Name = (dto.Locs != null && dto.Locs.Count > 0)? dto.Locs.Select(x => x.TransferToViewModel()).ToList().FirstOrDefault().Name : "",
                Key = dto.Key
                //Locs = dto.Locs != null ? dto.Locs.Select(x => x.TransferToViewModel()).ToList() : null

            };

            return viewModel;
        }

        /// <summary>
        /// Transfer from DirectoryViewModel to DirectoryDto
        /// </summary>
        /// <param name="view"></param>
        /// <returns></returns>
        public static DirectoryDto TransferToDtoModel(this DirectoryViewModel view)
        {
            DirectoryDto dto = new DirectoryDto()
            {
                Id = view.Id,
                IsActive = view.IsActive,
                Type = view.Type,
                ParentId = view.ParentId,
                Key = view.Key
                // Locs = view.Locs != null? view.Locs.Select(x => x.TransferToDtoModel()).ToList() : null
            };

            return dto;
        }


        public static DirectoryLocViewModel TransferToViewModel(this DirectoryLocDto dto)
        {
            DirectoryLocViewModel viewModel = new DirectoryLocViewModel()
            {
                Lang = dto.Lang,
                Name = dto.Name,
                DirectoryId = dto.DirectoryId

            };

            return viewModel;
        }

        /// <summary>
        /// Transfer from DirectoryViewModel to DirectoryDto
        /// </summary>
        /// <param name="view"></param>
        /// <returns></returns>
        public static DirectoryLocDto TransferToDtoModel(this DirectoryLocViewModel view)
        {
            DirectoryLocDto dto = new DirectoryLocDto()
            {
                Lang = view.Lang,
                Name = view.Name,
                DirectoryId = view.DirectoryId
            };

            return dto;
        }
    }
}
