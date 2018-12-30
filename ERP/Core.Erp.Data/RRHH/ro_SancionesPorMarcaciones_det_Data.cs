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
       public List<ro_SancionesPorMarcaciones_det_Info> get_list(int IdEmpresa, decimal IdAjuste)
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
                                 IdCalendario = q.IdCalendario,
                                 IdEmpleado = q.IdEmpleado,
                                 IdSucursal = q.IdSucursal,
                                 IdTipoMarcaciones = q.IdTipoMarcaciones,
                                 EsHoraHorario = q.EsHoraHorario,
                                 EsHoraMarcacion = q.EsHoraMarcacion,
                                 es_fechaRegistro = q.es_fechaRegistro,
                                 pe_cedulaRuc = q.pe_cedulaRuc,
                                 pe_apellido = q.pe_apellido,
                                 pe_nombre = q.pe_nombre,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 em_codigo = q.em_codigo,
                                 IdRegistro = q.IdRegistro,
                                 Minutos = q.Minutos,
                                 Observacion = q.Observacion
                             }).ToList();
                }

                return lista;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public List<ro_SancionesPorMarcaciones_det_Info> get_list(int IdEmpresa, int IdNomina, DateTime FechaInicio, DateTime FechaFin)
        {
            try
            {
                DateTime fi = FechaInicio.Date;
                DateTime ff = FechaFin.Date;
                List<ro_SancionesPorMarcaciones_det_Info> lista;
                using (Entities_rrhh context = new Entities_rrhh())
                {
                    lista = (from q in context.vwro_marcaciones_x_planificacion_horario

                             where q.IdEmpresa == IdEmpresa
                             && q.IdNomina == IdNomina
                             && q.es_fechaRegistro<=ff
                             && q.es_fechaRegistro>=fi
                             select new ro_SancionesPorMarcaciones_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdCalendario = q.IdCalendadrio,
                                 IdEmpleado = q.IdEmpleado,
                                 IdSucursal = q.IdSucursal,
                                 es_fechaRegistro = q.es_fechaRegistro,
                                 pe_cedulaRuc = q.pe_cedulaRuc,
                                 pe_apellido = q.pe_apellido,
                                 pe_nombre = q.pe_nombre,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 em_codigo = q.em_codigo,
                                 time_entrada1=q.time_entrada1,
                                 time_salida1=q.time_salida1,
                                 HoraIni=q.HoraIni,
                                 HoraFin=q.HoraFin
                             }).ToList();
                }

                lista.ForEach(item =>
               {
                   if(item.time_entrada1>item.HoraIni)
                   {
                       item.Minutos = item.time_entrada1.TotalHours - item.HoraIni.TotalHours;
                   }

                   if (item.time_salida1 < item.HoraFin)
                   {
                       item.Minutos = item.Minutos+( item.time_salida1.TotalHours - item.HoraFin.TotalHours);
                   }
               }
                );
                return lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
