using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Data.CuentasPorPagar;
namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_orden_pago_tipo_x_empresa_Bus
    {
        cp_orden_pago_tipo_x_empresa_Data oData = new cp_orden_pago_tipo_x_empresa_Data();
        public List<cp_orden_pago_tipo_x_empresa_Info> Get_list_cuotas_x_doc_det(int IdEmpresa)
        {
            try
            {
                return oData.get_list(IdEmpresa);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public cp_orden_pago_tipo_x_empresa_Info get_info(int IdEmpresa, string IdTipo_op)
        {
            try
            {
                return oData.get_info(IdEmpresa, IdTipo_op);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool eliminarDB(int IdEmpresa, decimal IdCuota)
        {
            try
            {
                return oData.eliminarDB(IdEmpresa, IdCuota);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool guardarDB(List<cp_orden_pago_tipo_x_empresa_Info> Lista)
        {
            try
            {
                return oData.guardarDB(Lista);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
