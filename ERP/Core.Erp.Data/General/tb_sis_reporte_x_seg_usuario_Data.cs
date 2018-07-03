using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
   public class tb_sis_reporte_x_seg_usuario_Data
    {
        public List<tb_sis_reporte_x_seg_usuario_Info> get_list(int IdEmpresa, string IdUsuario)
        {
            try
            {
                List<tb_sis_reporte_x_seg_usuario_Info> Lista;
                using (Entities_general Context = new Entities_general())
                {
                    Lista = (from q in Context.tb_sis_reporte_x_seg_usuario
                             where q.IdEmpresa == IdEmpresa
                             && q.IdUsuario == IdUsuario
                             select new tb_sis_reporte_x_seg_usuario_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdUsuario = q.IdUsuario,
                                 CodReporte = q.CodReporte
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, string IdUsuario)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    Context.Database.ExecuteSqlCommand("DELETE tb_sis_reporte_x_seg_usuario WHERE IdEmpresa = " + IdEmpresa + " AND IdUsuario = '" + IdUsuario + "'");
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(List<tb_sis_reporte_x_seg_usuario_Info> Lista, int IdEmpresa, string IdUsuario)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    foreach (var item in Lista)
                    {
                        tb_sis_reporte_x_seg_usuario Entity = new Data.tb_sis_reporte_x_seg_usuario
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdUsuario = item.IdUsuario,
                            CodReporte = item.CodReporte
                        };
                        Context.tb_sis_reporte_x_seg_usuario.Add(Entity);
                    }
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
