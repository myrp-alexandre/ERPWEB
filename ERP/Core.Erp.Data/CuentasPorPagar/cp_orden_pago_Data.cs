using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_orden_pago_Data
    {
        public List<cp_orden_pago_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<cp_orden_pago_Info> Lista;

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Lista = (from q in Context.cp_orden_pago
                             where IdEmpresa == q.IdEmpresa
                             select new cp_orden_pago_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdOrdenPago = q.IdOrdenPago,
                                 Observacion = q.Observacion,
                                 IdTipo_op = q.IdTipo_op,
                                 IdTipo_Persona = q.IdTipo_Persona,
                                 IdPersona = q.IdPersona,
                                 IdEntidad = q.IdEntidad,
                                 Fecha = q.Fecha,
                                 IdEstadoAprobacion = q.IdEstadoAprobacion,
                                 IdFormaPago = q.IdFormaPago,
                                 Fecha_Pago = q.Fecha_Pago,

                                 IdBanco = q.IdBanco,
                                 IdTipoFlujo = q.IdTipoFlujo,
                                 IdTipoMovi = q.IdTipoMovi,
                                 Estado =q.Estado,
                                 IdUsuario = q.IdUsuario,
                                 Fecha_Transac = q.Fecha_Transac

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
        
        public cp_orden_pago_Info get_info(int IdEmpresa, decimal IdOrdenPago)
        {
            try
            {
                cp_orden_pago_Info info = new cp_orden_pago_Info();

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_pago Entity = Context.cp_orden_pago.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdOrdenPago == IdOrdenPago);
                    if (Entity == null) return null;
                    info = new cp_orden_pago_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdOrdenPago = Entity.IdOrdenPago,
                        Observacion = Entity.Observacion,
                        IdTipo_op = Entity.IdTipo_op,
                        IdTipo_Persona = Entity.IdTipo_Persona,
                        IdPersona = Entity.IdPersona,
                        IdEntidad = Entity.IdEntidad,
                        Fecha = Entity.Fecha,
                        IdEstadoAprobacion = Entity.IdEstadoAprobacion,
                        IdFormaPago = Entity.IdFormaPago,
                        Fecha_Pago = Entity.Fecha_Pago,
                        IdBanco = Entity.IdBanco,
                        IdTipoFlujo = Entity.IdTipoFlujo,
                        IdTipoMovi = Entity.IdTipoMovi,
                        Estado = Entity.Estado,
                    };
                    info.detalle
                          = (from q in Context.cp_orden_pago_det
                             where q.IdOrdenPago == info.IdOrdenPago
                             && q.IdEmpresa == IdEmpresa
                             select new cp_orden_pago_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdOrdenPago = q.IdOrdenPago,
                                 Secuencia = q.Secuencia,
                                 IdEmpresa_cxp = q.IdEmpresa_cxp,
                                 IdCbteCble_cxp = q.IdCbteCble_cxp,
                                 IdTipoCbte_cxp = q.IdTipoCbte_cxp,
                                 Valor_a_pagar = q.Valor_a_pagar,
                                 Referencia = q.Referencia,
                                 IdFormaPago = q.IdFormaPago,
                                 Fecha_Pago = q.Fecha_Pago,
                                 IdEstadoAprobacion = q.IdEstadoAprobacion,
                                 IdBanco = q.IdBanco,
                                 IdUsuario_Aprobacion = q.IdUsuario_Aprobacion,
                                 fecha_hora_Aproba = q.fecha_hora_Aproba,
                                 Motivo_aproba=q.Motivo_aproba

                             }).ToList();
                }

                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 0;

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    var lst = from q in Context.cp_orden_pago
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() == 0)
                    {
                        ID = 1;
                    }
                    else
                    {
                        ID = lst.Max(q => q.IdOrdenPago) + 1;
                    }
                }

                return ID;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean guardarDB(cp_orden_pago_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {


                    cp_orden_pago Entity = new cp_orden_pago
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdOrdenPago = info.IdOrdenPago,
                        Observacion = info.Observacion,
                        IdTipo_op = info.IdTipo_op,
                        IdTipo_Persona = info.IdTipo_Persona,
                        IdPersona = info.IdPersona,
                        IdEntidad = info.IdEntidad,
                        Fecha = info.Fecha,
                        IdEstadoAprobacion = info.IdEstadoAprobacion,
                        IdFormaPago = info.IdFormaPago,
                        Fecha_Pago = info.Fecha_Pago,
                        IdBanco = info.IdBanco,
                        IdTipoFlujo = info.IdTipoFlujo,
                        IdTipoMovi = info.IdTipoMovi,
                        Estado = "A",
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = info.Fecha_Transac = DateTime.Now
                    };
                    Context.cp_orden_pago.Add(Entity);
                    Context.SaveChanges();
                }

                    cp_orden_pago_det_Data oData_det = new cp_orden_pago_det_Data();
                    foreach (var item in info.detalle)
                    {


                    }
                    return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean modificarDB(cp_orden_pago_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_pago Entity = Context.cp_orden_pago.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdOrdenPago == info.IdOrdenPago);
                    if (Entity != null)
                    {
                        Entity.Observacion = info.Observacion;
                        Entity.IdTipo_op = info.IdTipo_op;
                        Entity.IdTipo_Persona = info.IdTipo_Persona;
                        Entity.IdPersona = info.IdPersona;
                        Entity.IdEntidad = info.IdEntidad;
                        Entity.Fecha = info.Fecha;
                        Entity.IdEstadoAprobacion = info.IdEstadoAprobacion;
                        Entity.IdFormaPago = info.IdFormaPago;
                        Entity.Fecha_Pago = info.Fecha_Pago;
                        Entity.IdBanco = info.IdBanco;
                        Entity.IdTipoFlujo = info.IdTipoFlujo;
                        Entity.IdTipoMovi = info.IdTipoMovi;
                        Context.SaveChanges();

                        
                    }

                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean anularDB(cp_orden_pago_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_pago Entity = Context.cp_orden_pago.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdOrdenPago == info.IdOrdenPago);
                    if (Entity != null)
                    {
                        Entity.Estado = "I";
                        Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                        Entity.Fecha_UltAnu = info.Fecha_UltAnu=DateTime.Now;
                    }
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public Boolean modificar_estado_aprobacion(cp_orden_pago_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_orden_pago Entity = Context.cp_orden_pago.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdOrdenPago == info.IdOrdenPago);
                    if (Entity != null)
                    {
                        Entity.IdEstadoAprobacion = info.IdEstadoAprobacion;
                        Context.SaveChanges();
                        

                    }

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
