using Core.Erp.Data.Inventario;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Inventario
{
    public class in_Consignacion_det_Bus
    {
        in_Consignacion_Data odata = new in_Consignacion_Data();
        in_Consignacion_det_Data odata_det = new in_Consignacion_det_Data();

        public List<in_Consignacion_Info> get_list(int IdEmpresa, string signo, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                return odata.GetList(IdEmpresa, signo, mostrar_anulados, fecha_ini, fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public in_Consignacion_Info GetInfo(int IdEmpresa, int IdConsignacion)
        {
            try
            {
                return odata.GetInfo(IdEmpresa, IdConsignacion);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
