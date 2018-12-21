using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_NominasPagosCheques_det_Data
    {

        public List<ro_NominasPagosCheques_det_Info> get_lis(int IdEmpresa, decimal IdTransaccion)
        {
            try
            {
                List<ro_NominasPagosCheques_det_Info> lista;

                using (Entities_rrhh Contect=new Entities_rrhh())
                {
                    lista = (from q in Contect.ro_NominasPagosCheques_det

                             where q.IdEmpresa == IdEmpresa
                             && q.IdTransaccion == IdTransaccion
                             select new ro_NominasPagosCheques_det_Info
                             {
                                 IdEmpresa=q.IdEmpresa,
                                 IdTransaccion=q.IdTransaccion,
                                 Secuencia=q.Secuencia,
                                 IdEmpleado=q.IdEmpleado,
                                 IdEmpresa_op=q.IdEmpresa_op,
                                 IdOrdenPago=q.IdOrdenPago,
                                 Valor=q.Valor,
                                  IdSucursal=q.IdSucursal,
                                  Observacion=q.Observacion

                             }).ToList();

                    return lista;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
