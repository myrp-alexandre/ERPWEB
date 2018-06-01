using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_historico_vacaciones_x_empleado_Data
    {

        public List<ro_historico_vacaciones_x_empleado_Info> get_list(int IdEmpresa,decimal IdEmpleado)
        {
            List<ro_historico_vacaciones_x_empleado_Info> lst = new List<ro_historico_vacaciones_x_empleado_Info>();
            try
            {
                using (Entities_rrhh contex = new Entities_rrhh())
                {
                    var consultar = from q in contex.ro_historico_vacaciones_x_empleado
                                    where q.IdEmpleado == IdEmpleado &&
                                    q.IdEmpresa == IdEmpresa
                                    orderby q.FechaIni ascending
                                    select q;
                    foreach (var item in consultar)
                    {
                        ro_historico_vacaciones_x_empleado_Info info = new ro_historico_vacaciones_x_empleado_Info();
                        info.IdEmpresa = item.IdEmpresa;
                        info.IdEmpleado = item.IdEmpleado;
                        info.IdVacacion = item.IdVacacion;
                        info.IdPeriodo_Inicio = item.IdPeriodo_Inicio;
                        info.IdPeriodo_Fin = item.IdPeriodo_Fin;
                        info.FechaIni = item.FechaIni;
                        info.FechaFin = item.FechaFin;
                        info.DiasGanado = item.DiasGanado;
                        info.DiasTomados = item.DiasTomados;
                        lst.Add(info);
                    }
                }

                return lst;
            }
            catch (Exception )
            {
                
                throw ;
            }
        }
        public Boolean GrabarBD(ro_historico_vacaciones_x_empleado_Info info)
        {
            try
            {
                using (Entities_rrhh contex = new Entities_rrhh())
                {
                    ro_historico_vacaciones_x_empleado data = new ro_historico_vacaciones_x_empleado();
                    data.IdEmpresa = info.IdEmpresa;
                    data.IdEmpleado = info.IdEmpleado;
                    data.IdVacacion = info.IdVacacion;
                    data.IdPeriodo_Inicio = info.IdPeriodo_Inicio;
                    data.IdPeriodo_Fin = info.IdPeriodo_Fin;
                    data.FechaIni = info.FechaIni;
                    data.FechaFin = info.FechaFin;
                    data.DiasGanado = info.DiasGanado;
                    data.DiasTomados = info.DiasTomados;
                    contex.ro_historico_vacaciones_x_empleado.Add(data);
                    contex.SaveChanges();
                }
                return true;
            }
            catch (Exception )
            {

                throw ;
            }
        }
        public Boolean ModificarBD(ro_historico_vacaciones_x_empleado_Info info)
        {
            try
            {
                using (Entities_rrhh contex = new Entities_rrhh())
                {

                    var data = contex.ro_historico_vacaciones_x_empleado.First(a => a.IdEmpresa == info.IdEmpresa 
                    && a.IdEmpleado == info.IdEmpleado
                    && a.IdPeriodo_Inicio == info.IdPeriodo_Inicio
                    && a.IdPeriodo_Fin==info.IdPeriodo_Fin);

                    data.DiasGanado = info.DiasGanado;
                    data.DiasTomados = info.DiasTomados;
                    contex.SaveChanges();
                }
                return true;
            }
            catch (Exception )
            {
                
                throw ;
            }
        }
        public Boolean GetExiste(ro_historico_vacaciones_x_empleado_Info info, ref string msg)
        {
            try
            {
                Boolean valorRetornar = false;
                using (Entities_rrhh contex = new Entities_rrhh())
                {
                    int cont = (from a in contex.ro_historico_vacaciones_x_empleado
                                where a.IdEmpresa == info.IdEmpresa && a.IdEmpleado == info.IdEmpleado
                                && a.IdPeriodo_Inicio == info.IdPeriodo_Inicio
                                && a.IdPeriodo_Fin == info.IdPeriodo_Fin
                                select a).Count();

                    if (cont > 0) { valorRetornar = true; }
                    else { valorRetornar = false; }
                }
                return valorRetornar;
            }
            catch (Exception )
            {
               
                throw ;
            }
        }
    }
}
