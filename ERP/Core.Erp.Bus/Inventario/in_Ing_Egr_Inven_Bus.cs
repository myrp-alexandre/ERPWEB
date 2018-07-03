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
    
        public List<in_Ing_Egr_Inven_Info> get_list(int IdEmpresa,  string signo, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
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

        public bool guardarDB(in_Ing_Egr_Inven_Info info)
        {
            try
            {
                return odata.guardarDB(info);
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
                if (odata_det.eliminarDB(info.IdEmpresa, info.IdSucursal, info.IdMovi_inven_tipo, info.IdNumMovi))
                    odata.modificarDB(info);
                return true;
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

    }
}
