using Microsoft.AspNetCore.Http;
using Prorent24.BLL.Services.CrewMember;
using Prorent24.Common.Models.Columns;
using Prorent24.Common.Models.Trees;
using Prorent24.DAL.Storages.Configuration.Account.UserRole;
using Prorent24.DAL.Storages.Configuration.Financial.AdditionalCondition;
using Prorent24.DAL.Storages.General.Column;
using Prorent24.Entity.General;
using Prorent24.Enum.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Prorent24.BLL.Services.General.Grid
{
    internal class GridService : BaseService, IGridService
    {
        private readonly ICrewMemberService _crewMemberService;
        private readonly IAdditionalConditionStorage _additionalCondition;

        public GridService(IColumnStorage сolumnStorage,
            ICrewMemberService crewMemberService,
            IAdditionalConditionStorage additionalCondition,
            IHttpContextAccessor httpContextAccessor,
            IUserRoleStorage userRoleStorage) : base(httpContextAccessor, userRoleStorage, сolumnStorage)
        {
            _additionalCondition = additionalCondition;
            _crewMemberService = crewMemberService;
        }

        /// <summary>
        /// Get list column groups with include columns
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public async Task<List<ColumnGroup>> GetColumnGroupsByEntity(EntityEnum entity)
        {
            return await System.Threading.Tasks.Task.Run(() =>
               {
                   List<ColumnGroup> columnGroup = entity.GenerateColumnGroupByEntity();
                   return columnGroup;
               });

        }

        #region Columns

        /// <summary>
        /// Add new column
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="columns"></param>
        /// <returns></returns>
        public async Task AddColumns(EntityEnum entity, params TreeColumn[] columns)
        {
            string userId = GetUserId();

            List<UserColumnEntity> userColumnEntities = await _columnStorage.GetColumnsByEntity(entity, userId);
            userColumnEntities.ForEach(x =>
            {
                x.ShowColumn = false;
            });

            for (int i = 0; i < columns.Length; i++)
            {
                string column = columns[i].Id;

                int index = userColumnEntities.FindIndex(x => x.Column == column);

                if (index > -1)
                {
                    userColumnEntities[index].ShowColumn = true;
                }
                else
                {
                    await this._columnStorage.Create(new UserColumnEntity()
                    {
                        Entity = entity,
                        ShowColumn = true,
                        CreationUserId = GetUserId(),
                        CreationDate = DateTime.Now,
                        LastModifiedDate = DateTime.Now,
                        Column = column,
                        Order = -1
                    });
                }
            }

            await this._columnStorage.Update(userColumnEntities);

        }

        /// <summary>
        /// Update columns
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="columns"></param>
        /// <returns></returns>
        public async Task UpdateColumns(EntityEnum entity, List<string> columns)
        {
            string userId = GetUserId();

            List<UserColumnEntity> userColumnEntities = await _columnStorage.GetColumnsByEntity(entity, userId);
            userColumnEntities.ForEach(x =>
            {
                x.ShowColumn = false;
            });

            for (int i = 0; i < columns.Count; i++)
            {
                string column = columns[i];

                int index = userColumnEntities.FindIndex(x => x.Column == column);

                if (index > -1)
                {
                    userColumnEntities[index].ShowColumn = true;
                }
                else
                {
                    await this._columnStorage.Create(new UserColumnEntity()
                    {
                        Entity = entity,
                        ShowColumn = true,
                        CreationUserId = GetUserId(),
                        CreationDate = DateTime.Now,
                        LastModifiedDate = DateTime.Now,
                        Column = column,
                        Order = -1
                    });
                }
            }

            await this._columnStorage.Update(userColumnEntities);

        }

        /// <summary>
        /// Change Order Column
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="column"></param>
        /// <param name="newIndex"></param>
        /// <param name="columnsReorder"></param>
        /// <returns></returns>
        public async Task ChangeOrderColumn(EntityEnum entity, string column, short newIndex, List<ColumnReorder> columnsReorder)
        {
            column = column.Trim();

            List<UserColumnEntity> columnsFromDb = await this._columnStorage.GetColumnsByEntity(entity, GetUserId());

            foreach (ColumnReorder item in columnsReorder)
            {
                int index = columnsFromDb.FindIndex(x => x.Column == item.Column);

                if (index < 0)
                {
                    columnsFromDb.Add(new UserColumnEntity()
                    {
                        Entity = entity,
                        ShowColumn = !item.Hidden,
                        CreationUserId = GetUserId(),
                        CreationDate = DateTime.Now,
                        LastModifiedDate = DateTime.Now,
                        Column = item.Column,
                        WidthColumn = item.Width,
                        Order = item.Column.Equals(column) ? newIndex : item.Index
                    });
                }
                else
                {
                    columnsFromDb[index].Order = item.Index;
                    columnsFromDb[index].WidthColumn = item.Width;
                    columnsFromDb[index].ShowColumn = !item.Hidden;
                    columnsFromDb[index].LastModifiedDate = DateTime.Now;
                }
            }

            await this._columnStorage.Update(columnsFromDb);
        }

        /// <summary>
        /// Change Width Column
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="column"></param>
        /// <param name="width"></param>
        /// <returns></returns>
        public async Task ChangeWidthColumn(EntityEnum entity, string column, double width)
        {
            column = column.Trim();

            UserColumnEntity columnEntity = await this._columnStorage.GetColumn(entity, GetUserId(), column);

            if (columnEntity != null && columnEntity.Id > 0)
            {
                columnEntity.WidthColumn = width;

                await this._columnStorage.Update(columnEntity);
            }
            else
            {
                await this._columnStorage.Create(new UserColumnEntity()
                {
                    Entity = entity,
                    ShowColumn = true,
                    CreationUserId = GetUserId(),
                    CreationDate = DateTime.Now,
                    LastModifiedDate = DateTime.Now,
                    Column = column,
                    WidthColumn = width,
                    Order = -1
                });
            }
        }

        #endregion
    }
}
