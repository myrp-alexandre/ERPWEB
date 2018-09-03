using Core.Erp.Info.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Compras
{
    public class com_ordencompra_local_Data
    {
        public List<com_ordencompra_local_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<com_ordencompra_local_Info> Lista;
                using (Entities_compras Context = new Entities_compras())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.com_ordencompra_local
                                 where q.IdEmpresa == IdEmpresa
                                 select new com_ordencompra_local_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdComprador = q.IdComprador,
                                     IdOrdenCompra = q.IdOrdenCompra,
                                     IdDepartamento = q.IdDepartamento,
                                     IdEstadoAprobacion_cat = q.IdEstadoAprobacion_cat,
                                     IdEstadoRecepcion_cat = q.IdEstadoRecepcion_cat,
                                     IdEstado_cierre = q.IdEstado_cierre,
                                     IdMotivo = q.IdMotivo,
                                     IdProveedor = q.IdProveedor,
                                     IdSolicitante = q.IdSolicitante,
                                     IdSucursal = q.IdSucursal,
                                     IdTerminoPago = q.IdTerminoPago,
                                     IdUsuario_Aprueba = q.IdUsuario_Aprueba,
                                     IdUsuario_Reprue = q.IdUsuario_Reprue,
                                     Estado = q.Estado,
                                     Tipo = q.Tipo,
                                     Solicitante = q.Solicitante,
                                     oc_plazo = q.oc_plazo,
                                     oc_observacion = q.oc_observacion,
                                     oc_fecha = q.oc_fecha,
                                     oc_fechaVencimiento = q.oc_fechaVencimiento,
                                     oc_flete = q.oc_flete,
                                     oc_NumDocumento = q.oc_NumDocumento,
                                     AfectaCosto = q.AfectaCosto,
                                     co_fechaReproba = q.co_fechaReproba,
                                     co_fecha_aprobacion = q.co_fecha_aprobacion
                                 }).ToList();
                    else
                        Lista = (from q in Context.com_ordencompra_local
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new com_ordencompra_local_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdComprador = q.IdComprador,
                                     IdOrdenCompra = q.IdOrdenCompra,
                                     IdDepartamento = q.IdDepartamento,
                                     IdEstadoAprobacion_cat = q.IdEstadoAprobacion_cat,
                                     IdEstadoRecepcion_cat = q.IdEstadoRecepcion_cat,
                                     IdEstado_cierre = q.IdEstado_cierre,
                                     IdMotivo = q.IdMotivo,
                                     IdProveedor = q.IdProveedor,
                                     IdSolicitante = q.IdSolicitante,
                                     IdSucursal = q.IdSucursal,
                                     IdTerminoPago = q.IdTerminoPago,
                                     IdUsuario_Aprueba = q.IdUsuario_Aprueba,
                                     IdUsuario_Reprue = q.IdUsuario_Reprue,
                                     Estado = q.Estado,
                                     Tipo = q.Tipo,
                                     Solicitante = q.Solicitante,
                                     oc_plazo = q.oc_plazo,
                                     oc_observacion = q.oc_observacion,
                                     oc_fecha = q.oc_fecha,
                                     oc_fechaVencimiento = q.oc_fechaVencimiento,
                                     oc_flete = q.oc_flete,
                                     oc_NumDocumento = q.oc_NumDocumento,
                                     AfectaCosto = q.AfectaCosto,
                                     co_fechaReproba = q.co_fechaReproba,
                                     co_fecha_aprobacion = q.co_fecha_aprobacion,
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public com_ordencompra_local_Info get_info(int IdEmpresa, int IdSucursal, decimal IdOrdenCompra)
        {
            try
            {
                com_ordencompra_local_Info info = new com_ordencompra_local_Info();
                using (Entities_compras Context = new Entities_compras())
                {
                    com_ordencompra_local Entity = Context.com_ordencompra_local.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdOrdenCompra == IdOrdenCompra).FirstOrDefault();
                    if (Entity == null) return null;

                    info = new com_ordencompra_local_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdComprador = Entity.IdComprador,
                        IdOrdenCompra = Entity.IdOrdenCompra,
                        IdDepartamento = Entity.IdDepartamento,
                        IdEstadoAprobacion_cat = Entity.IdEstadoAprobacion_cat,
                        IdEstadoRecepcion_cat = Entity.IdEstadoRecepcion_cat,
                        IdEstado_cierre = Entity.IdEstado_cierre,
                        IdMotivo = Entity.IdMotivo,
                        IdProveedor = Entity.IdProveedor,
                        IdSolicitante = Entity.IdSolicitante,
                        IdSucursal = Entity.IdSucursal,
                        IdTerminoPago = Entity.IdTerminoPago,
                        IdUsuario_Aprueba = Entity.IdUsuario_Aprueba,
                        IdUsuario_Reprue = Entity.IdUsuario_Reprue,
                        Estado = Entity.Estado,
                        Tipo = Entity.Tipo,
                        Solicitante = Entity.Solicitante,
                        oc_plazo = Entity.oc_plazo,
                        oc_observacion = Entity.oc_observacion,
                        oc_fecha = Entity.oc_fecha,
                        oc_fechaVencimiento = Entity.oc_fechaVencimiento,
                        oc_flete = Entity.oc_flete,
                        oc_NumDocumento = Entity.oc_NumDocumento,
                        AfectaCosto = Entity.AfectaCosto,
                        co_fechaReproba = Entity.co_fechaReproba,
                        co_fecha_aprobacion = Entity.co_fecha_aprobacion
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa, int idSucursal)
        {
            try
            {
                decimal Id = 1;
                using (Entities_compras Context = new Entities_compras())
                {
                    var lst = from q in Context.com_ordencompra_local
                              where q.IdEmpresa == IdEmpresa
                              && q.IdSucursal == idSucursal
                              select q;
                    if (lst.Count() > 0)
                        Id = lst.Max(q => q.IdOrdenCompra) + 1;
                }
                return Id;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(com_ordencompra_local_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_ordencompra_local Entity = new com_ordencompra_local
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdComprador = info.IdComprador,
                        IdOrdenCompra = info.IdOrdenCompra=get_id(info.IdEmpresa , info.IdSucursal),
                        IdDepartamento = info.IdDepartamento,
                        IdEstadoAprobacion_cat = info.IdEstadoAprobacion_cat,
                        IdEstadoRecepcion_cat = info.IdEstadoRecepcion_cat,
                        IdEstado_cierre = info.IdEstado_cierre,
                        IdMotivo = info.IdMotivo,
                        IdProveedor = info.IdProveedor,
                        IdSolicitante = info.IdSolicitante,
                        IdSucursal = info.IdSucursal,
                        IdTerminoPago = info.IdTerminoPago,
                        IdUsuario_Aprueba = info.IdUsuario_Aprueba,
                        IdUsuario_Reprue = info.IdUsuario_Reprue,
                        Estado = "A",
                        Tipo = info.Tipo,
                        Solicitante = info.Solicitante,
                        oc_plazo = info.oc_plazo,
                        oc_observacion = info.oc_observacion,
                        oc_fecha = info.oc_fecha,
                        oc_fechaVencimiento = info.oc_fechaVencimiento,
                        oc_flete = info.oc_flete,
                        oc_NumDocumento = info.oc_NumDocumento,
                        AfectaCosto = info.AfectaCosto,
                        co_fechaReproba = info.co_fechaReproba,
                        co_fecha_aprobacion = info.co_fecha_aprobacion,

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.com_ordencompra_local.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(com_ordencompra_local_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_ordencompra_local Entity = Context.com_ordencompra_local.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdOrdenCompra == info.IdOrdenCompra).FirstOrDefault();
                    if (Entity == null) return false;

                     Entity.IdComprador = info.IdComprador;
                     Entity.IdDepartamento = info.IdDepartamento;
                     Entity.IdEstadoAprobacion_cat = info.IdEstadoAprobacion_cat;
                     Entity.IdEstadoRecepcion_cat = info.IdEstadoRecepcion_cat;
                     Entity.IdEstado_cierre = info.IdEstado_cierre;
                     Entity.IdMotivo = info.IdMotivo;
                     Entity.IdProveedor = info.IdProveedor;
                     Entity.IdSolicitante = info.IdSolicitante;
                     Entity.IdSucursal = info.IdSucursal;
                     Entity.IdTerminoPago = info.IdTerminoPago;
                     Entity.IdUsuario_Aprueba = info.IdUsuario_Aprueba;
                     Entity.IdUsuario_Reprue = info.IdUsuario_Reprue;
                     Entity.Tipo = info.Tipo;
                     Entity.Solicitante = info.Solicitante;
                     Entity.oc_plazo = info.oc_plazo;
                     Entity.oc_observacion = info.oc_observacion;
                     Entity.oc_fecha = info.oc_fecha;
                     Entity.oc_fechaVencimiento = info.oc_fechaVencimiento;
                     Entity.oc_flete = info.oc_flete;
                     Entity.oc_NumDocumento = info.oc_NumDocumento;
                     Entity.AfectaCosto = info.AfectaCosto;
                     Entity.co_fechaReproba = info.co_fechaReproba;
                     Entity.co_fecha_aprobacion = info.co_fecha_aprobacion;

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

        public bool anularDB(com_ordencompra_local_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_ordencompra_local Entity = Context.com_ordencompra_local.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdOrdenCompra == info.IdOrdenCompra).FirstOrDefault();
                    if (Entity == null) return false;

                    Entity.Estado = "I";
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.FechaHoraAnul = DateTime.Now;

                    Context.SaveChanges();

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
