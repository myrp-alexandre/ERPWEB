using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Consignacion_Data
    {
        public List<in_Consignacion_Info> GetList(int IdEmpresa, int IdSucursal, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                List<in_Consignacion_Info> Lista = new List<in_Consignacion_Info>();

                using (Entities_inventario db = new Entities_inventario())
                {
                    if (mostrar_anulados == false)
                    {
                        Lista = db.vwin_Consignacion.Where(q => q.IdEmpresa == IdEmpresa && q.Estado == true).Select(q => new in_Consignacion_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdConsignacion = q.IdConsignacion,
                            IdSucursal = q.IdSucursal,
                            Fecha = q.Fecha,
                            IdProveedor = q.IdProveedor,
                            NombreProveedor = q.NombreProveedor,
                            Su_Descripcion = q.Su_Descripcion,
                            bo_Descripcion = q.bo_Descripcion,
                            NombreTipoMovimiento = q.NombreTipoMovimiento,
                            IdNumMovi = q.IdNumMovi,
                            Observacion = q.Observacion,
                            Estado = q.Estado                            
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.vwin_Consignacion.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new in_Consignacion_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdConsignacion = q.IdConsignacion,
                            IdSucursal = q.IdSucursal,
                            Fecha = q.Fecha,
                            IdProveedor = q.IdProveedor,
                            NombreProveedor = q.NombreProveedor,
                            Su_Descripcion = q.Su_Descripcion,
                            bo_Descripcion = q.bo_Descripcion,
                            NombreTipoMovimiento = q.NombreTipoMovimiento,
                            IdNumMovi = q.IdNumMovi,
                            Observacion = q.Observacion,
                            Estado = q.Estado
                        }).ToList();
                    }
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public in_Consignacion_Info GetInfo(int IdEmpresa, int IdConsignacion)
        {
            try
            {
                in_Consignacion_Info info = new in_Consignacion_Info();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Consignacion Entity = Context.in_Consignacion.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdConsignacion == IdConsignacion);    
                    
                    if (Entity == null)
                    {
                        return null;
                    }
                    info = new in_Consignacion_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdConsignacion = Entity.IdConsignacion,
                        IdSucursal = Entity.IdSucursal,
                        Fecha = Entity.Fecha,
                        IdProveedor = Entity.IdProveedor,
                        Observacion = Entity.Observacion,
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

        public decimal GetId(int IdEmpresa)
        {

            try
            {
                decimal ID = 1;
                using (Entities_inventario db = new Entities_inventario())
                {
                    var Lista = db.in_Consignacion.Where(q=>q.IdEmpresa == IdEmpresa).Select(q =>q.IdConsignacion);

                    if (Lista.Count() > 0)
                        ID = Lista.Max() + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public in_Ing_Egr_Inven_Info armar_movi_inven(in_Consignacion_Info info, int IdMoviInven_tipo, string nomContacto)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    var motivo = Context.in_Motivo_Inven.Where(q => q.IdEmpresa == info.IdEmpresa && q.Tipo_Ing_Egr == "EGR" && q.Genera_Movi_Inven == "S").FirstOrDefault();
                    if (motivo == null)
                        return null;

                    var tipo = Context.in_movi_inven_tipo.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdMovi_inven_tipo == IdMoviInven_tipo).FirstOrDefault();
                    if (tipo == null)
                        return null;

                    int secuencia = 1;

                    in_Ing_Egr_Inven_Info movimiento = new in_Ing_Egr_Inven_Info
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdBodega = info.IdBodega,
                        IdMovi_inven_tipo = IdMoviInven_tipo,
                        IdNumMovi = 0,
                        cm_fecha = info.Fecha,
                        cm_observacion = "CONS# " + info.IdConsignacion + " " + "PROVEEDOR: " + info.NombreProveedor + " " + info.Observacion,
                        IdUsuario = info.IdUsuario,
                        IdUsuarioUltModi = info.IdUsuarioUltMod,
                        IdMotivo_Inv = motivo.IdMotivo_Inv,
                        signo = "-",
                        CodMoviInven = "CONS# " + info.IdConsignacion,
                        lst_in_Ing_Egr_Inven_det = new List<in_Ing_Egr_Inven_det_Info>()
                    };
                    foreach (var item in info.lst_producto_consignacion)
                    {
                        var lst = Context.in_Producto_Composicion.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdProductoPadre == item.IdProducto).ToList();
                        if (lst.Count == 0)
                        {
                            var producto = (from p in Context.in_Producto
                                            join t in Context.in_ProductoTipo
                                            on new { p.IdEmpresa, p.IdProductoTipo } equals new { t.IdEmpresa, t.IdProductoTipo }
                                            where p.IdEmpresa == info.IdEmpresa && p.IdProducto == item.IdProducto
                                            && t.tp_ManejaInven == "S"
                                            select p).FirstOrDefault();

                            if (producto != null)
                            {
                                movimiento.lst_in_Ing_Egr_Inven_det.Add(new in_Ing_Egr_Inven_det_Info
                                {
                                    IdEmpresa = movimiento.IdEmpresa,
                                    IdSucursal = movimiento.IdSucursal,
                                    IdBodega = (int)movimiento.IdBodega,
                                    IdMovi_inven_tipo = movimiento.IdMovi_inven_tipo,
                                    IdNumMovi = 0,
                                    Secuencia = secuencia++,
                                    IdProducto = item.IdProducto,
                                    dm_cantidad = item.Cantidad * -1,
                                    dm_cantidad_sinConversion = item.Cantidad * -1,
                                    mv_costo = 0,
                                    mv_costo_sinConversion = 0,
                                    IdUnidadMedida = producto.IdUnidadMedida_Consumo,
                                    IdUnidadMedida_sinConversion = producto.IdUnidadMedida_Consumo
                                });
                            }
                        }
                        else
                        {
                            foreach (var comp in lst)
                            {
                                var producto = (from p in Context.in_Producto
                                                join t in Context.in_ProductoTipo
                                                on new { p.IdEmpresa, p.IdProductoTipo } equals new { t.IdEmpresa, t.IdProductoTipo }
                                                where p.IdEmpresa == info.IdEmpresa && p.IdProducto == item.IdProducto
                                                && t.tp_ManejaInven == "S"
                                                select p).FirstOrDefault();

                                if (producto != null)
                                {
                                    movimiento.lst_in_Ing_Egr_Inven_det.Add(new in_Ing_Egr_Inven_det_Info
                                    {
                                        IdEmpresa = movimiento.IdEmpresa,
                                        IdSucursal = movimiento.IdSucursal,
                                        IdBodega = (int)movimiento.IdBodega,
                                        IdMovi_inven_tipo = movimiento.IdMovi_inven_tipo,
                                        IdNumMovi = 0,
                                        Secuencia = secuencia++,
                                        IdProducto = comp.IdProductoHijo,
                                        dm_cantidad = item.Cantidad * -1,
                                        dm_cantidad_sinConversion = item.Cantidad * -1,
                                        mv_costo = 0,
                                        mv_costo_sinConversion = 0,
                                        IdUnidadMedida = producto.IdUnidadMedida_Consumo,
                                        IdUnidadMedida_sinConversion = producto.IdUnidadMedida_Consumo
                                    });
                                }
                            }
                        }
                    }
                    if (movimiento.lst_in_Ing_Egr_Inven_det.Count == 0)
                        return null;
                    return movimiento;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool GuardarBD(in_Consignacion_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    db.in_Consignacion.Add(new in_Consignacion
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdConsignacion = info.IdConsignacion = GetId(info.IdEmpresa),
                        IdSucursal = info.IdSucursal,
                        IdBodega = info.IdBodega,
                        Fecha = info.Fecha,
                        IdProveedor = info.IdProveedor,
                        Observacion = info.Observacion,
                        Estado = true,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now,
                        IdMovi_inven_tipo = 2,
                        IdNumMovi = 10
                    });

                    if (info.lst_producto_consignacion != null)
                    {
                        int Secuencia = 1;
                        foreach (var item in info.lst_producto_consignacion)
                        {
                            db.in_ConsignacionDet.Add(new in_ConsignacionDet
                            {
                                IdEmpresa = info.IdEmpresa,
                                IdConsignacion = info.IdConsignacion,
                                Secuencia = Secuencia++,
                                IdProducto = item.IdProducto,
                                IdUnidadMedida = item.IdUnidadMedida,
                                Cantidad = item.Cantidad,                                
                                Costo = item.Costo,
                                Observacion = info.Observacion
                            });

                        }
                    }

                    db.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool ModificarDB(in_Consignacion_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    in_Consignacion Entity = db.in_Consignacion.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdConsignacion == info.IdConsignacion).FirstOrDefault();

                    if (Entity == null)
                    {
                        return false;
                    }

                    Entity.IdConsignacion = info.IdConsignacion;
                    Entity.IdProveedor = info.IdProveedor;
                    Entity.IdSucursal = info.IdSucursal;
                    Entity.Fecha = info.Fecha;
                    Entity.Observacion = info.Observacion;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;

                    db.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }        

        public bool AnularBD(in_Consignacion_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    in_Consignacion Entity = db.in_Consignacion.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdConsignacion == info.IdConsignacion).FirstOrDefault();

                    if (Entity == null)
                    {
                        return false;
                    }

                    Entity.Estado = info.Estado;
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;

                    db.SaveChanges();
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
