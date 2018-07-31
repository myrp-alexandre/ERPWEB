using Core.Erp.Data.Inventario;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Inventario
{
    public class in_Ing_Egr_Inven_Bus
    {
        in_Ing_Egr_Inven_Data odata = new in_Ing_Egr_Inven_Data();
        in_Ing_Egr_Inven_det_Data odata_det = new in_Ing_Egr_Inven_det_Data();

        public List<in_Ing_Egr_Inven_Info> get_list(int IdEmpresa, string signo, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, signo, mostrar_anulados, fecha_ini, fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public in_Ing_Egr_Inven_Info get_info(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_Ing_Egr_Inven_Info info, string signo)
        {
            try
            {
                return odata.guardarDB(info, signo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(in_Ing_Egr_Inven_Info info)
        {
            try
            {
                return odata.modificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(in_Ing_Egr_Inven_Info info)
        {
            try
            {
                return odata.anularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public Boolean Reversar_Aprobacion(int IdEmpresa, int IdSucursal, int IdMovi_inve_tipo, decimal IdNumMovi, string Genera_movi_inven)
        {
            try
            {
                return odata.Reversar_Aprobacion(IdEmpresa, IdSucursal, IdMovi_inve_tipo, IdNumMovi, Genera_movi_inven);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<in_Ing_Egr_Inven_Info> get_list_por_devolver(int IdEmpresa, string signo, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                return odata.get_list_por_devolver(IdEmpresa, signo, Fecha_ini, Fecha_fin);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
