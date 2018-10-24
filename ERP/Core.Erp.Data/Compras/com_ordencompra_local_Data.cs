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
                        Lista = (from q in Context.vwcom_ordencompra_local
                                 where q.IdEmpresa == IdEmpresa
                                 select new com_ordencompra_local_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdComprador = q.IdComprador,
                                     IdOrdenCompra = q.IdOrdenCompra,
                                     IdDepartamento = q.IdDepartamento,
                                     IdEstadoAprobacion_cat = q.IdEstadoAprobacion_cat,
                                     IdEstado_cierre = q.IdEstado_cierre,
                                     IdMotivo = q.IdMotivo,
                                     IdProveedor = q.IdProveedor,
                                     IdSucursal = q.IdSucursal,
                                     IdTerminoPago = q.IdTerminoPago,
                                     IdUsuario_Aprueba = q.IdUsuario_Aprueba,
                                     IdUsuario_Reprue = q.IdUsuario_Reprue,
                                     Estado = q.Estado,
                                     oc_plazo = q.oc_plazo,
                                     oc_observacion = q.oc_observacion,
                                     oc_fecha = q.oc_fecha,
                                     oc_fechaVencimiento = q.oc_fechaVencimiento,
                                     oc_NumDocumento = q.oc_NumDocumento,
                                     co_fechaReproba = q.co_fechaReproba,
                                     co_fecha_aprobacion = q.co_fecha_aprobacion,

                                     EstadoBool = q.Estado == "A" ? true : false,
                                     pr_codigo = q.pr_codigo,
                                     Nombre = q.Nombre,
                                     pe_nombreCompleto = q.pe_nombreCompleto,
                                     pe_cedulaRuc = q.pe_cedulaRuc
                                     
                                 }).ToList();
                    else
                        Lista = (from q in Context.vwcom_ordencompra_local
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new com_ordencompra_local_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdComprador = q.IdComprador,
                                     IdOrdenCompra = q.IdOrdenCompra,
                                     IdDepartamento = q.IdDepartamento,
                                     IdEstadoAprobacion_cat = q.IdEstadoAprobacion_cat,
                                     IdEstado_cierre = q.IdEstado_cierre,
                                     IdMotivo = q.IdMotivo,
                                     IdProveedor = q.IdProveedor,
                                     IdSucursal = q.IdSucursal,
                                     IdTerminoPago = q.IdTerminoPago,
                                     IdUsuario_Aprueba = q.IdUsuario_Aprueba,
                                     IdUsuario_Reprue = q.IdUsuario_Reprue,
                                     Estado = q.Estado,
                                     oc_plazo = q.oc_plazo,
                                     oc_observacion = q.oc_observacion,
                                     oc_fecha = q.oc_fecha,
                                     oc_fechaVencimiento = q.oc_fechaVencimiento,
                                     oc_NumDocumento = q.oc_NumDocumento,
                                     co_fechaReproba = q.co_fechaReproba,
                                     co_fecha_aprobacion = q.co_fecha_aprobacion,

                                     EstadoBool = q.Estado == "A" ? true : false,
                                     pr_codigo = q.pr_codigo,
                                     Nombre = q.Nombre,
                                     pe_nombreCompleto = q.pe_nombreCompleto,
                                     pe_cedulaRuc = q.pe_cedulaRuc
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
                        IdEstado_cierre = Entity.IdEstado_cierre,
                        IdMotivo = Entity.IdMotivo,
                        IdProveedor = Entity.IdProveedor,
                        IdSucursal = Entity.IdSucursal,
                        IdTerminoPago = Entity.IdTerminoPago,
                        IdUsuario_Aprueba = Entity.IdUsuario_Aprueba,
                        IdUsuario_Reprue = Entity.IdUsuario_Reprue,
                        Estado = Entity.Estado,
                        oc_plazo = Entity.oc_plazo,
                        oc_observacion = Entity.oc_observacion,
                        oc_fecha = Entity.oc_fecha,
                        oc_fechaVencimiento = Entity.oc_fechaVencimiento,
                        oc_NumDocumento = Entity.oc_NumDocumento,
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
                        IdEstado_cierre = info.IdEstado_cierre,
                        IdMotivo = info.IdMotivo,
                        IdProveedor = info.IdProveedor,
                        IdSucursal = info.IdSucursal,
                        IdTerminoPago = info.IdTerminoPago,
                        IdUsuario_Aprueba = info.IdUsuario_Aprueba,
                        IdUsuario_Reprue = info.IdUsuario_Reprue,
                        Estado = "A",
                        oc_plazo = info.oc_plazo,
                        oc_observacion = info.oc_observacion,
                        oc_fecha = info.oc_fecha,
                        oc_fechaVencimiento = info.oc_fechaVencimiento,
                        oc_NumDocumento = info.oc_NumDocumento,
                        co_fechaReproba = info.co_fechaReproba,
                        co_fecha_aprobacion = info.co_fecha_aprobacion,

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };

                    Context.com_ordencompra_local.Add(Entity);

                    foreach (var item in info.lst_det)
                        {
                            com_ordencompra_local_det Entity_det = new com_ordencompra_local_det
                             {
                                IdEmpresa = info.IdEmpresa,
                                IdOrdenCompra = info.IdOrdenCompra,
                                IdSucursal = info.IdSucursal,
                                IdProducto = item.IdProducto,
                                IdCod_Impuesto = item.IdCod_Impuesto,
                                IdUnidadMedida = item.IdUnidadMedida,
                                do_Cantidad = item.do_Cantidad,
                                do_descuento = item.do_descuento,
                                do_iva = item.do_iva,
                                do_observacion = item.do_observacion,
                                do_porc_des = item.do_porc_des,
                                do_precioCompra = item.do_precioCompra,
                                do_precioFinal = item.do_precioFinal,
                                do_subtotal = item.do_subtotal,
                                do_total = item.do_total,
                                Por_Iva = item.Por_Iva,
                                Secuencia = item.Secuencia
                            };
                        Context.com_ordencompra_local_det.Add(Entity_det);

                    }
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
                     Entity.IdEstado_cierre = info.IdEstado_cierre;
                     Entity.IdMotivo = info.IdMotivo;
                     Entity.IdProveedor = info.IdProveedor;
                     Entity.IdSucursal = info.IdSucursal;
                     Entity.IdTerminoPago = info.IdTerminoPago;
                     Entity.IdUsuario_Aprueba = info.IdUsuario_Aprueba;
                     Entity.IdUsuario_Reprue = info.IdUsuario_Reprue;
                     Entity.oc_plazo = info.oc_plazo;
                     Entity.oc_observacion = info.oc_observacion;
                     Entity.oc_fecha = info.oc_fecha;
                     Entity.oc_fechaVencimiento = info.oc_fechaVencimiento;
                     Entity.oc_NumDocumento = info.oc_NumDocumento;
                     Entity.co_fechaReproba = info.co_fechaReproba;
                     Entity.co_fecha_aprobacion = info.co_fecha_aprobacion;

                     Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                     Entity.Fecha_UltMod = DateTime.Now;
                    var det = Context.com_ordencompra_local_det.Where(v => v.IdEmpresa == info.IdEmpresa && v.IdSucursal == info.IdSucursal && v.IdOrdenCompra == info.IdOrdenCompra);
                    Context.com_ordencompra_local_det.RemoveRange(det);
                    foreach (var item in info.lst_det)
                    {
                        com_ordencompra_local_det Entity_det = new com_ordencompra_local_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = info.IdSucursal,
                            IdOrdenCompra = info.IdOrdenCompra,
                            IdProducto = item.IdProducto,
                            IdCod_Impuesto = item.IdCod_Impuesto,
                            IdUnidadMedida = item.IdUnidadMedida,
                            do_Cantidad = item.do_Cantidad,
                            do_descuento = item.do_descuento,
                            do_iva = item.do_iva,
                            do_observacion = item.do_observacion,
                            do_porc_des = item.do_porc_des,
                            do_precioCompra = item.do_precioCompra,
                            do_precioFinal = item.do_precioFinal,
                            do_subtotal = item.do_subtotal,
                            do_total = item.do_total,
                            Por_Iva = item.Por_Iva,
                            Secuencia = item.Secuencia
                        };
                        Context.com_ordencompra_local_det.Add(Entity_det);

                    }
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
