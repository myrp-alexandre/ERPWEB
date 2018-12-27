using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
   public class ro_SancionesPorMarcaciones_det_Data
    {
       public List<ro_SancionesPorMarcaciones_det_Info> get_list(int IdEmpresa, int IdAjuste)
        {
            try
            {
                List<ro_SancionesPorMarcaciones_det_Info> lista;
                using (Entities_rrhh context=new Entities_rrhh())
                {
                    lista = (from q in context.vwro_SancionesPorMarcaciones_det

                             where q.IdEmpleado == IdEmpresa
                             && q.IdAjuste == IdAjuste
                             select new ro_SancionesPorMarcaciones_det_Info
                             {
                                IdEmpresa=q.IdEmpresa,
                                IdAjuste=q.IdAjuste,
                                Secuencia=q.Secuencia,
                                IdCalendario=q.IdCalendario,
                                IdEmpleado=q.IdEmpleado,
                                IdSucursal=q.IdSucursal,
                                IdTipoMarcaciones=q.IdTipoMarcaciones,
                                EsHoraHorario=q.EsHoraHorario,
                                EsHoraMarcacion=q.EsHoraMarcacion,
                                es_fechaRegistro=q.es_fechaRegistro,
                                pe_cedulaRuc=q.pe_cedulaRuc,
                                pe_apellido=q.pe_apellido,
                                pe_nombre=q.pe_nombre,
                                pe_nombreCompleto=q.pe_nombreCompleto,
                                em_codigo=q.em_codigo,
                                IdRegistro=q.IdRegistro,
                                Minutos=q.Minutos,
                                Observacion=q.Observacion
                             }).ToList();
                }

                return lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
