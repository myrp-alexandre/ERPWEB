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
                                 nom_presentacion=q.nom_presentacion,
                                 ca_Categoria=q.ca_Categoria,
                                 Secuencia_fact=q.Secuencia_fact,
                                 IdCbteVta=q.IdCbteVta_fact

                             }).ToList();
                }
                Lista.ForEach(V =>
                {
                    V.pr_descripcion = V.pr_descripcion + " " + V.pr_descripcion +"-"+V.nom_presentacion+"-"+V.ca_Categoria+ " - " + V.lote_num_lote + " - " + (V.lote_fecha_vcto != null ? Convert.ToDateTime(V.lote_fecha_vcto).ToString("dd/MM/yyyy") : "");
                });
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
