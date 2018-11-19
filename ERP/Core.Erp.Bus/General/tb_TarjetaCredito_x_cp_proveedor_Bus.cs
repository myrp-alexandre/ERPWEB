using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.General
{
    public class tb_TarjetaCredito_x_cp_proveedor_Bus
    {
        tb_TarjetaCredito_x_cp_proveedor_Data odata = new tb_TarjetaCredito_x_cp_proveedor_Data();

        public List<tb_TarjetaCredito_x_cp_proveedor_Info> GetList(bool MostrarAnulado, int IdEmpresa)
        {
            try
            {
                return odata.GetList(MostrarAnulado, IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public tb_TarjetaCredito_x_cp_proveedor_Info GetInfo(int IdEmpresa, int IdTransaccion, int IdTarjeta, decimal IdProveedor)
        {
            try

            {
                return odata.GetInfo(IdEmpresa, IdTransaccion, IdTarjeta, IdProveedor);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool GuardarBD(tb_TarjetaCredito_x_cp_proveedor_Info info)
        {
            try
            {
                return odata.GuardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool ModificarBD(tb_TarjetaCredito_x_cp_proveedor_Info info)
        {
            try
            {
                return odata.ModificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool validar_existe_tarjeta_proveedor(int IdEmpresa, int IdTransaccion, int IdTarjeta, decimal IdProveedor)
        {
            try
            {
                return odata.validar_existe_tarjeta_proveedor(IdEmpresa, IdTransaccion, IdTarjeta, IdProveedor);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool AnularBD(tb_TarjetaCredito_x_cp_proveedor_Info info)
        {
            try
            {
                return odata.AnularBD(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
