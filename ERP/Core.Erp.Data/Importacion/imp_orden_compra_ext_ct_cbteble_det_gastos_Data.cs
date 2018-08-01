using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Importacion;
namespace Core.Erp.Data.Importacion
{
   public class imp_orden_compra_ext_ct_cbteble_det_gastos_Data
    {
        public List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> get_list_gastos_no_asignados(int IdEmpresa, string IdCtaCble)
        {
            try
            {
                List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.vwimp_gastos_no_asignados
                             where q.IdEmpresa == IdEmpresa
                             && q.IdCtaCble == IdCtaCble
                             select new imp_orden_compra_ext_ct_cbteble_det_gastos_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpresa_ct=q.IdEmpresa,
                                 IdTipoCbte=q.IdTipoCbte,
                                 IdCbteCble=q.IdCbteCble,
                                 secuencia_ct=q.secuencia,
                                 dc_Valor=q.dc_Valor,
                                 pc_Cuenta=q.pc_Cuenta,
                                 dc_Observacion=q.dc_Observacion,

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> get_list_gastos_asignados(int IdEmpresa, decimal IdOrdenCompra_ext)
        {
            try
            {
                List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.imp_orden_compra_ext_ct_cbteble_det_gastos
                             where q.IdEmpresa == IdEmpresa
                             && q.IdOrdenCompra_ext == IdOrdenCompra_ext
                             select new imp_orden_compra_ext_ct_cbteble_det_gastos_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdOrdenCompra_ext = q.IdOrdenCompra_ext,
                                 IdEmpresa_ct = q.IdEmpresa_ct,
                                 IdTipoCbte = q.IdTipoCbte,
                                 IdCbteCble = q.IdCbteCble,
                                 secuencia_ct = q.secuencia_ct,
                                 IdGasto_tipo = q.IdGasto_tipo
                                 //dc_Valor = q.dc_Valor,
                                 //pc_Cuenta=q.pc_Cuenta,
                                 //dc_Observacion=q.dc_Observacion

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
