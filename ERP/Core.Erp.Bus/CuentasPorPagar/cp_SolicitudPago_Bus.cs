using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.CuentasPorPagar
{
    public class cp_SolicitudPago_Bus
    {
        cp_SolicitudPago_Data odata = new cp_SolicitudPago_Data();
        public List<cp_SolicitudPago_Info> GetList(int IdEmpresa, int IdSucursal, DateTime Fecha_ini, DateTime Fecha_fin, bool mostrar_anulados)
        {
            try
            {
                return odata.GetList(IdEmpresa, IdSucursal, Fecha_ini, Fecha_fin, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cp_SolicitudPago_Info GetInfo(int IdEmpresa, decimal IdSolicitud)
        {
            try
            {
                return odata.GetInfo(IdEmpresa, IdSolicitud);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool GuardarDB(cp_SolicitudPago_Info info)
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

        public bool ModificarDB(cp_SolicitudPago_Info info)
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

        public bool AnularDB(cp_SolicitudPago_Info info)
        {
            try
            {
                return odata.AnularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }


    }
}
