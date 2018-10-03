using Core.Erp.Info.Caja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Core.Erp.Data.Caja
{
    public class caj_Caja_Movimiento_Data
    {
        public List<caj_Caja_Movimiento_Info> get_list (int IdEmpresa, string cm_signo, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                fecha_ini = fecha_ini.Date;
                fecha_fin = fecha_fin.Date;
                List<caj_Caja_Movimiento_Info> Lista;
                using (Entities_caja Context = new Entities_caja())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.vwcaj_Caja_Movimiento
                                 where q.IdEmpresa == IdEmpresa
                                 && q.cm_Signo == cm_signo
                                 && fecha_ini <= q.cm_fecha && q.cm_fecha <= fecha_fin
                                 orderby q.IdCbteCble descending
                                 select new caj_Caja_Movimiento_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdCaja = q.IdCaja,
                                     IdTipocbte = q.IdTipocbte,
                                     IdCbteCble = q.IdCbteCble,
                                     cm_observacion = q.cm_observacion,
                                     cm_Signo = q.cm_Signo,
                                     Estado = q.Estado,
                                     cm_fecha = q.cm_fecha,
                                     ca_Descripcion = q.ca_Descripcion,
                                     pe_nombreCompleto = q.pe_nombreCompleto,
                                     tm_descripcion = q.tm_descripcion,
                                     cm_valor = q.cm_valor,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                    else
                        Lista = (from q in Context.vwcaj_Caja_Movimiento
                                 where q.IdEmpresa == IdEmpresa
                                 && q.cm_Signo == cm_signo
                                 && fecha_ini <= q.cm_fecha && q.cm_fecha <= fecha_fin
                                 && q.Estado =="A"
                                 orderby q.IdCbteCble descending
                                 select new caj_Caja_Movimiento_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdCaja = q.IdCaja,
                                     IdTipocbte = q.IdTipocbte,
                                     IdCbteCble = q.IdCbteCble,
                                     cm_observacion = q.cm_observacion,
                                     cm_Signo = q.cm_Signo,
                                     Estado = q.Estado,
                                     cm_fecha = q.cm_fecha,
                                     ca_Descripcion = q.ca_Descripcion,
                                     pe_nombreCompleto = q.pe_nombreCompleto,
                                     tm_descripcion = q.tm_descripcion,
                                     cm_valor = q.cm_valor,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public caj_Caja_Movimiento_Info get_info(int IdEmpresa, int IdTipocbte, decimal IdCbteCble)
        {
            try
            {
                caj_Caja_Movimiento_Info info = new caj_Caja_Movimiento_Info();
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento Entity = Context.caj_Caja_Movimiento.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdTipocbte == IdTipocbte && q.IdCbteCble == IdCbteCble );
                    if (Entity == null) return null;
                    info = new caj_Caja_Movimiento_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdCaja = Entity.IdCaja,
                        IdTipocbte = Entity.IdTipocbte,
                        IdCbteCble = Entity.IdCbteCble,
                        IdEntidad = Entity.IdEntidad,
                        IdPeriodo = Entity.IdPeriodo,
                        IdPersona = Entity.IdPersona,
                        IdTipoFlujo = Entity.IdTipoFlujo,
                        IdTipoMovi = Entity.IdTipoMovi,
                        IdTipo_Persona = Entity.IdTipo_Persona,
                        cm_fecha = Entity.cm_fecha,
                        cm_observacion = Entity.cm_observacion,
                        cm_Signo = Entity.cm_Signo,
                        cm_valor = Entity.cm_valor,
                        CodMoviCaja = Entity.CodMoviCaja,
                        Estado = Entity.Estado
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(caj_Caja_Movimiento_Info info)
        {
            try
            {
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento Entity = new caj_Caja_Movimiento
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdCaja = info.IdCaja,
                        IdTipocbte = info.IdTipocbte,
                        IdCbteCble = info.IdCbteCble,
                        IdEntidad = info.IdEntidad,
                        IdPeriodo = info.IdPeriodo = Convert.ToInt32(info.cm_fecha.ToString("yyyyMM")),
                        IdPersona = info.IdPersona,
                        IdTipoFlujo = info.IdTipoFlujo,
                        IdTipoMovi = info.IdTipoMovi,
                        IdTipo_Persona = info.IdTipo_Persona,
                        cm_fecha = info.cm_fecha.Date,
                        cm_observacion = info.cm_observacion,
                        cm_Signo = info.cm_Signo,
                        cm_valor = info.cm_valor,
                        CodMoviCaja = info.CodMoviCaja,
                        Estado = info.Estado="A",

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    caj_Caja_Movimiento_det Entity_det = new caj_Caja_Movimiento_det
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdTipocbte = info.IdTipocbte,
                        IdCbteCble = info.IdCbteCble,
                        cr_Valor = info.info_caj_Caja_Movimiento_det.cr_Valor,
                        IdCobro_tipo = info.info_caj_Caja_Movimiento_det.IdCobro_tipo,
                        Secuencia = 1                        
                    };
                    Context.caj_Caja_Movimiento.Add(Entity);
                    Context.caj_Caja_Movimiento_det.Add(Entity_det);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(caj_Caja_Movimiento_Info info)
        {
            try
            {
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento Entity = Context.caj_Caja_Movimiento.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdTipocbte == info.IdTipocbte && q.IdCbteCble == info.IdCbteCble);
                    if (Entity == null) return false;

                    Entity.cm_fecha = info.cm_fecha.Date;
                    Entity.IdPeriodo = info.IdPeriodo = Convert.ToInt32(info.cm_fecha.ToString("yyyyMM"));
                    Entity.cm_observacion = info.cm_observacion;
                    Entity.CodMoviCaja = info.CodMoviCaja;
                    Entity.cm_valor = info.cm_valor;
                    Entity.IdPersona = info.IdPersona;
                    Entity.IdTipo_Persona = info.IdTipo_Persona;
                    Entity.IdEntidad = info.IdEntidad;
                    Entity.IdCaja = info.IdCaja;

                    caj_Caja_Movimiento_det Entity_det = Context.caj_Caja_Movimiento_det.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdTipocbte == info.IdTipocbte && q.IdCbteCble == info.IdCbteCble);
                    if(Entity_det == null) return false;

                    Entity_det.IdCobro_tipo = info.info_caj_Caja_Movimiento_det.IdCobro_tipo;
                    Entity_det.cr_Valor = info.info_caj_Caja_Movimiento_det.cr_Valor;


                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(caj_Caja_Movimiento_Info info)
        {
            try
            {
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento Entity = Context.caj_Caja_Movimiento.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdTipocbte == info.IdTipocbte && q.IdCbteCble == info.IdCbteCble);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado="I";

                    Entity.IdUsuario_Anu = info.IdUsuario_Anu;
                    Entity.FechaAnulacion = DateTime.Now;
                    Context.SaveChanges();

                    Context.Database.ExecuteSqlCommand("DELETE cp_conciliacion_Caja_det_x_ValeCaja WHERE IdEmpresa_movcaja = " + info.IdEmpresa+ " AND IdTipocbte_movcaja = " + info.IdTipocbte+ " AND IdCbteCble_movcaja = " + info.IdCbteCble);
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
