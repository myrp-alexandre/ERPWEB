using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Data.CuentasPorPagar;

namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_cuotas_x_doc_Bus
    {
        cp_cuotas_x_doc_Data oData = new cp_cuotas_x_doc_Data();

        public List<cp_cuotas_x_doc_Info> get_list(int IdEmpresa)
        {
            try
            {
                return oData.get_list(IdEmpresa);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public cp_cuotas_x_doc_Info get_info(int IdEmpresa, decimal IdCuota)
        {
            try
            {
                return oData.get_info(IdEmpresa, IdCuota);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public cp_cuotas_x_doc_Info get_info(int IdEmpresa, int IdTipoCbte, decimal IdCbteCble)
        {
            try
            {
                return oData.get_info(IdEmpresa, IdTipoCbte, IdCbteCble);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public Boolean GuardarDB(cp_cuotas_x_doc_Info info)
        {
            try
            {
                return oData.guardarDB(info);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public Boolean ModificarDB(cp_cuotas_x_doc_Info info)
        {
            try
            {
                return oData.modificarDB(info);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public Boolean AnularDB(cp_cuotas_x_doc_Info info)
        {
            try
            {
                return oData.anularDB(info);
            }
            catch (Exception )
            {
                throw;
            }
        }
    }
}
