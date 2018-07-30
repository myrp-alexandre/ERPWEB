using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
   public class fa_guia_remision_det_Data
    {
        public List<fa_guia_remision_det_Info> get_list(int IdEmpresa, decimal IdGuiaRemision)
        {
            try
            {
                List<fa_guia_remision_det_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.vwfa_guia_remision_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdGuiaRemision == IdGuiaRemision
                             select new fa_guia_remision_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdProducto = q.IdProducto,
                                 IdGuiaRemision = q.IdGuiaRemision,
                                 Secuencia = q.Secuencia,
                                 gi_cantidad = q.gi_cantidad,
                                 gi_detallexItems = q.gi_detallexItems,
                                 pr_descripcion=q.pr_descripcion,
                                 

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool eliminar(int IdEmpresa, decimal IdGuiaRemision)
        {
            try
            {
                using (Entities_importacion context = new Entities_importacion())
                {
                    string sql = "delete fa_guia_remision_det where IdEmpresa='" + IdEmpresa + "' and IdGuiaRemision='" + IdGuiaRemision + "'";
                    context.Database.ExecuteSqlCommand(sql);
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
