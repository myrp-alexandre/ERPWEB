using Core.Erp.Data.Inventario;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Inventario
{
    public class in_devolucion_inven_Bus
    {
        in_devolucion_inven_Data odata = new in_devolucion_inven_Data();
        public List<in_devolucion_inven_Info> get_list(int IdEmpresa, int IdSucursal, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, Fecha_ini, Fecha_fin);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public in_devolucion_inven_Info get_info(int IdEmpresa, decimal IdDev_Inven)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdDev_Inven);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool guardarDB(in_devolucion_inven_Info info)
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

        public bool modificarDB(in_devolucion_inven_Info info)
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

        public bool anularDB(in_devolucion_inven_Info info)
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
