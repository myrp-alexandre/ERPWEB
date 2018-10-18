using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
    public class ROL_017_Data
    {
        public List<ROL_017_Info> get_list(int IdEmpresa , decimal IdEmpleado, DateTime fechaIni, DateTime fechaFin)
        {
            try
            {
                decimal IdEmpleadoIni = IdEmpleado;
                decimal IdEmpleadoFin = IdEmpleado == 0 ? 9999 : IdEmpleado;

                fechaFin = Convert.ToDateTime(fechaFin.ToShortDateString());
                fechaIni = Convert.ToDateTime(fechaIni.ToShortDateString());

                List<ROL_017_Info> Lista;

                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.SPROL_017(IdEmpresa, fechaIni, fechaFin)
                             where q.IdEmpleado >= IdEmpleadoIni && q.IdEmpleado <= IdEmpleadoFin
                             select new ROL_017_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 Entrada1 =q.Entrada1,
                                 Entrada2 =q.Entrada2,
                                 es_anio =q.es_anio,
                                 es_dia = q.es_dia,
                                 es_fechaRegistro = q.es_fechaRegistro,
                                 es_Hora = q.es_Hora,
                                 es_mes = q.es_mes,
                                 es_sdia = q.es_sdia,
                                 es_semana = q.es_semana,
                                 ma_descripcion = q.ma_descripcion,
                                 pe_cedulaRuc = q.pe_cedulaRuc,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 RegresoLounch = q.RegresoLounch,
                                 Salida1 = q.Salida1,
                                 Salida2 = q.Salida2,
                                 SalidaLounch = q.SalidaLounch
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
