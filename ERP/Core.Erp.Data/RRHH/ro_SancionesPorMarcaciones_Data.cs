using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
   public class ro_SancionesPorMarcaciones_Data
    {
        public List<ro_SancionesPorMarcaciones_Info> get_list(int IdEmpresa, DateTime Fechainicio, DateTime FechaFin)
        {
            try
            {
                List<ro_SancionesPorMarcaciones_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    
                        Lista = (from q in Context.vwro_SancionesPorMarcaciones
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_SancionesPorMarcaciones_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdAjuste = q.IdEmpresa,
                                     IdNomina_Tipo = q.IdNomina_Tipo,
                                     IdNomina_TipoLiqui = q.IdNomina_TipoLiqui,
                                     FechaInicio = q.FechaInicio,
                                     FechaFin = q.FechaFin,
                                     Observacion = q.Observacion,
                                     Descripcion=q.Descripcion,
                                     DescripcionProcesoNomina=q.DescripcionProcesoNomina,
                                     FechaNovedades=q.FechaNovedades,
                                     
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_SancionesPorMarcaciones_Info info)
        {
            try
            {
                ro_empleado_novedad_Data odata_novedad = new ro_empleado_novedad_Data();

                decimal IdNovedad = odata_novedad.get_id(info.IdEmpresa);
                int secuancia = 1;
                using (Entities_rrhh Context = new Entities_rrhh())
                {

                    ro_SancionesPorMarcaciones entity = new ro_SancionesPorMarcaciones
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdAjuste = info.IdAjuste= get_id(info.IdEmpresa),
                        IdNomina_Tipo = info.IdNomina_Tipo,
                        IdNomina_TipoLiqui = info.IdNomina_TipoLiqui,
                        FechaInicio = info.FechaInicio, FechaFin = info.FechaFin,
                        Observacion = info.Observacion,
                        Fecha_Transac = DateTime.Now,
                        IdUsuario=info.IdUsuario,
                        Estado = true,
                        FechaNovedades = info.FechaNovedades

                    };
                    Context.ro_SancionesPorMarcaciones.Add(entity);
                    foreach (var item in info.detalle)
                    {

                        ro_SancionesPorMarcaciones_det entity_det = new ro_SancionesPorMarcaciones_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = item.IdSucursal,
                            IdAjuste = info.IdAjuste,
                            IdCalendario = item.IdCalendario,
                            IdEmpleado = item.IdEmpleado,
                            EsHoraIngreso = item.HoraIni,
                            HoraIngreso = item.time_entrada1,
                            EsHoraSalida = item.HoraFin,
                            HoraSalio = item.time_salida1,
                            Minutos = item.Minutos,
                            FechaRegistro = item.es_fechaRegistro,
                            Secuencia=secuancia
                        };
                        Context.ro_SancionesPorMarcaciones_det.Add(entity_det);
                        secuancia++;
                    }

                    // agrupnado para obter valor para novedad
                    secuancia = 1;
                    var lista_novedades = (from q in info.detalle
                                           group q by new
                                           {
                                               q.IdEmpresa,
                                               q.IdSucursal,
                                               q.IdEmpleado,
                                               q.Minutos,
                                               q.Sueldo
                                           } into Grupo
                                           select new ro_SancionesPorMarcaciones_x_novedad_Info
                                           {
                                               IdEmpresa = Grupo.Key.IdEmpresa,
                                               IdSucursal = Grupo.Key.IdSucursal,
                                               IdEmpleado = Grupo.Key.IdEmpleado,
                                               Valor = Grupo.Sum(s => s.Minutos),
                                               Sueldo = Grupo.Key.Sueldo

                                           }).ToList();
                    // grabando novedades
                    foreach (var item in lista_novedades)
                    {
                        ro_empleado_Novedad novedad = new ro_empleado_Novedad
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = item.IdSucursal,
                            IdNovedad = IdNovedad,
                            IdEmpleado = item.IdEmpleado,
                            IdNomina_Tipo = info.IdNomina_Tipo,
                            IdNomina_TipoLiqui = info.IdNomina_TipoLiqui,
                            Observacion="Novedad generada por proceso del sistema fecha descuento "+info.FechaNovedades.ToString().Substring(0,10),
                            Fecha = info.FechaNovedades,
                            Estado = "A",
                            Fecha_Transac = DateTime.Now,
                            IdUsuario=info.IdUsuario
                        };
                        Context.ro_empleado_Novedad.Add(novedad);

                        ro_empleado_novedad_det novedad_det = new ro_empleado_novedad_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdNovedad = IdNovedad,
                            IdRubro = "200",
                            Valor = item.Valor * (((Convert.ToDouble(item.Sueldo)) / 240) / 60),
                            FechaPago = info.FechaNovedades,
                            EstadoCobro = "PEN",
                            Observacion = "Novedad generda por proceso del sistema",
                            Secuencia = 1,
                        };
                        novedad_det.Valor = Math.Round(novedad_det.Valor, 2);
                        Context.ro_empleado_novedad_det.Add(novedad_det);

                        ro_SancionesPorMarcaciones_x_novedad novedad_x_sanc = new ro_SancionesPorMarcaciones_x_novedad
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdAjuste = info.IdAjuste,
                            Secuencia=secuancia,
                            IdNovedad=novedad.IdNovedad,
                            IdEmpresa_nov=info.IdEmpresa,
                            IdEmpleado=item.IdEmpleado,
                            IdNomina_Tipo=info.IdNomina_Tipo,
                            IdNomina_TipoLiqui=info.IdNomina_TipoLiqui
                        };
                        Context.ro_SancionesPorMarcaciones_x_novedad.Add(novedad_x_sanc);
                        IdNovedad++;
                        secuancia++;
                    }

                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public bool modificarDB(ro_SancionesPorMarcaciones_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {

                    ro_SancionesPorMarcaciones entity = Context.ro_SancionesPorMarcaciones.Where(v => v.IdEmpresa == info.IdEmpresa && v.IdAjuste == info.IdAjuste).FirstOrDefault();
                    if (entity == null)
                        return false;
                    entity.FechaInicio = info.FechaInicio;
                    entity.FechaFin = info.FechaFin;
                    entity.Observacion = info.Observacion;
                    entity.FechaNovedades = info.FechaNovedades;
                    entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
               
                        }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_SancionesPorMarcaciones_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {

                    ro_SancionesPorMarcaciones entity = Context.ro_SancionesPorMarcaciones.Where(v => v.IdEmpresa == info.IdEmpresa && v.IdAjuste == info.IdAjuste).FirstOrDefault();
                    if (entity == null)
                        return false;
                    entity.Estado =false;
                    entity.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();

                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_SancionesPorMarcaciones_Info get_info(int IdEmpresa, int IdAjuste)
        {
            try
            {
                using (Entities_rrhh Context=new Entities_rrhh())
                {
                    ro_SancionesPorMarcaciones entity = Context.ro_SancionesPorMarcaciones.Where(v => v.IdEmpresa == IdEmpresa && v.IdAjuste == IdAjuste).FirstOrDefault();

                    if (entity == null)
                        return new ro_SancionesPorMarcaciones_Info();

                    ro_SancionesPorMarcaciones_Info info = new ro_SancionesPorMarcaciones_Info
                    {
                        IdEmpresa = entity.IdEmpresa,
                        IdAjuste = entity.IdEmpresa,
                        IdNomina_Tipo = entity.IdNomina_Tipo,
                        IdNomina_TipoLiqui = entity.IdNomina_TipoLiqui,
                        FechaInicio = entity.FechaInicio,
                        FechaFin = entity.FechaFin,
                        Observacion = entity.Observacion,
                        FechaNovedades=entity.FechaNovedades
                    };

                    return info;

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public int get_id(int IdEmpresa)
        {
            try
            {
                using (Entities_rrhh Context=new Entities_rrhh())
                {
                    var select = (from q in Context.ro_SancionesPorMarcaciones
                                  where q.IdEmpresa == IdEmpresa
                                  select q
                                );
                    if (select.Count() == 0)
                        return 1;
                    else
                        return select.Count() + 1;

                }

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
