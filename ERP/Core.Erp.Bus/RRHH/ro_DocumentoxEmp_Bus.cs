using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
namespace Core.Erp.Bus.RRHH
{
    public class ro_DocumentoxEmp_Bus
    {
        ro_DocumentoxEmp_Data odata = new ro_DocumentoxEmp_Data();
        public List<ro_DocumentoxEmp_Info> get_list(int IdEmpresa)
        {
            try
            {
                return odata.get_list(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_DocumentoxEmp_Info get_info(int IdEmpresa, int IdEmpleado, int IdDocumento)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdEmpleado, IdDocumento);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_DocumentoxEmp_Info info)
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
        public bool anularDB(ro_DocumentoxEmp_Info info)
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
