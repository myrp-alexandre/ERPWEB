using Core.Erp.Info.RRHH.MTE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
  public  class ro_archivosCSV_Data
    {

        public List<ro_archivosCSV_Info> Get_lst_detalle_contabilizar(int idEmpresa, int IdRol, int IdRubro)
        {

            try
            {
                List<ro_archivosCSV_Info> oListado = new List<ro_archivosCSV_Info>();

                using (Entities_rrhh db = new Entities_rrhh())
                {
                    oListado = from q in db.spROL_DecimosCSV(idEmpresa, IdRol, IdRubro)
                               select new ro_rol_detalle_Info
                               {
                                   IdEmpresa = q.IdEmpresa,
                                   IdEmpleado = q.IdEmpleado,
                                   pe_ape

                               }).ToList();
                }
                return oListado;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
