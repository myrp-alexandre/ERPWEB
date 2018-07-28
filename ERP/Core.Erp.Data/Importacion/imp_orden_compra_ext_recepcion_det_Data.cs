using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Importacion;
namespace Core.Erp.Data.Importacion
{
   public class imp_orden_compra_ext_recepcion_det_Data
    {
        public List<imp_orden_compra_ext_recepcion_det_Info> get_list(int IdEmpresa, decimal IdRecepcion)
        {
            try
            {
                List<imp_orden_compra_ext_recepcion_det_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.vwimp_orden_compra_ext_recepcion_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdRecepcion == IdRecepcion
                             select new imp_orden_compra_ext_recepcion_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdRecepcion = q.IdRecepcion,
                                 secuencia = q.secuencia,
                                 IdProducto = q.IdProducto,                                
                                 IdEmpresa_oc=q.IdEmpresa_oc,
                                 IdOrdenCompra_ext = q.IdOrdenCompra_ext,
                                 Secuencia_oc=q.Secuencia_oc,
                                 cantidad=q.cantidad,
                                 Observacion=q.Observacion,
                                 od_cantidad=q.od_cantidad,
                                 pr_descripcion=q.pr_descripcion,
                                 IdUnidadMedida=q.IdUnidadMedida

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public bool eliminar(int IdEmpresa, decimal IdRecepcion)
        {
            try
            {
                using (Entities_importacion context = new Entities_importacion())
                {
                    string sql = "delete imp_orden_compra_ext_recepcion_det where IdEmpresa='" + IdEmpresa + "' and IdRecepcion='" + IdRecepcion + "'";
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
