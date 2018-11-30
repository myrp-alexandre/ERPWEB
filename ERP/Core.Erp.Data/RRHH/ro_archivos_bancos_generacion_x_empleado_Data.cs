using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
   public class ro_archivos_bancos_generacion_x_empleado_Data
    {
        public List<ro_archivos_bancos_generacion_x_empleado_Info> get_list(int IdEmpresa, decimal IdArchivo)
        {
            try
            {
                List<ro_archivos_bancos_generacion_x_empleado_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.vwro_archivos_bancos_generacion_x_empleado
                             where q.IdEmpresa == IdEmpresa
                                   && q.IdArchivo == IdArchivo
                             select new ro_archivos_bancos_generacion_x_empleado_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdArchivo = q.IdArchivo,
                                 IdEmpleado = q.IdEmpleado,
                                 IdSucursal = q.IdSucursal,
                                 Valor = q.Valor,
                                  pagacheque=q.pagacheque,
                                  em_tipoCta=q.em_tipoCta,
                                  em_NumCta=q.em_NumCta,
                                  pe_apellido=q.pe_apellido,
                                  pe_nombre=q.pe_nombre,
                                  pe_cedulaRuc=q.pe_cedulaRuc,
                                  IdTipoDocumento=q.IdTipoDocumento
                                  
                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
