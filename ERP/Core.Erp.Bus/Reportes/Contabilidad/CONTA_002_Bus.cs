using Core.Erp.Data.Reportes.Contabilidad;
using Core.Erp.Info.Reportes.Contabilidad;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Reportes.Contabilidad
{
    public class CONTA_002_Bus
    {
        CONTA_002_Data odata = new CONTA_002_Data();
    
        public List<CONTA_002_Info> get_list(int IdEmpresa, string IdCtaCble, DateTime fechaIni, DateTime fechaFin)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdCtaCble, fechaIni, fechaFin);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
