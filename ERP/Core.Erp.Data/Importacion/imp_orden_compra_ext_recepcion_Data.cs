using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Importacion;
namespace Core.Erp.Data.Importacion
{
   public class imp_orden_compra_ext_recepcion_Data
    {

        public List<imp_orden_compra_ext_recepcion_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime Fecha_fin)
        {
            try
            {
                List<imp_orden_compra_ext_recepcion_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.vwimp_orden_compra_ext_recepcion
                             where q.IdEmpresa == IdEmpresa
                             && q.or_fecha >= fecha_inicio
                             && q.or_fecha <= Fecha_fin
                             select new imp_orden_compra_ext_recepcion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdRecepcion = q.IdRecepcion,
                                 or_fecha = q.or_fecha,
                                 or_observacion = q.or_observacion,
                                 IdEmpresa_oc = q.IdEmpresa_oc,
                                 IdOrdenCompraExt = q.IdOrdenCompraExt,
                                 IdEmpresa_inv = q.IdEmpresa_inv,
                                 IdSucursal_inv = q.IdSucursal_inv,
                                 IdMovi_inven_tipo_inv = q.IdMovi_inven_tipo_inv,
                                 IdNumMovi_inv = q.IdNumMovi_inv,
                                 pe_cedulaRuc=q.pe_cedulaRuc,
                                 pe_nombreCompleto=q.pe_nombreCompleto,
                                 estado=q.estado

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public imp_orden_compra_ext_recepcion_Info get_info(int IdEmpresa, decimal IdRecepcion)
        {
            try
            {
                imp_orden_compra_ext_recepcion_Info info = new imp_orden_compra_ext_recepcion_Info();
                using (Entities_importacion Context = new Entities_importacion())
                {
                    vwimp_orden_compra_ext_recepcion Entity = Context.vwimp_orden_compra_ext_recepcion.FirstOrDefault(q => q.IdRecepcion == IdRecepcion && q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new imp_orden_compra_ext_recepcion_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdRecepcion = Entity.IdRecepcion,
                        or_fecha = Entity.or_fecha,
                        or_observacion = Entity.or_observacion,
                        IdEmpresa_oc = Entity.IdEmpresa_oc,
                        IdOrdenCompraExt = Entity.IdOrdenCompraExt,
                        IdEmpresa_inv = Entity.IdEmpresa_inv,
                        IdSucursal_inv = Entity.IdSucursal_inv,
                        IdMovi_inven_tipo_inv = Entity.IdMovi_inven_tipo_inv,
                        IdNumMovi_inv = Entity.IdNumMovi_inv,
                        IdBodega=Entity.IdBodega,
                        IdMotivo_Inv=Entity.IdMotivo_Inv,
                        IdCatalogo_via=Entity.IdCatalogo_via,
                        pe_nombreCompleto=Entity.pe_nombreCompleto
                        
                        
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    var lst = from q in Context.imp_orden_compra_ext_recepcion
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdRecepcion) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(imp_orden_compra_ext_recepcion_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_orden_compra_ext_recepcion Entity = new imp_orden_compra_ext_recepcion
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdRecepcion = info.IdRecepcion = get_id(info.IdEmpresa),
                        or_fecha = info.or_fecha,
                        or_observacion = info.or_observacion,
                        IdEmpresa_oc = info.IdEmpresa,
                        IdOrdenCompraExt = info.IdOrdenCompraExt,
                        IdEmpresa_inv = info.IdEmpresa,
                        IdSucursal_inv = info.IdSucursal_inv,
                        IdMovi_inven_tipo_inv = info.IdMovi_inven_tipo_inv,
                        IdMotivo_Inv = info.IdMotivo_Inv,
                        IdNumMovi_inv = info.IdNumMovi_inv,
                        IdBodega = info.IdBodega,
                        estado = true

                    };

                    foreach (var item in info.lst_detalle)
                    {
                        imp_orden_compra_ext_det detalle = Context.imp_orden_compra_ext_det.FirstOrDefault( q => 
                        q.IdEmpresa==item.IdEmpresa
                        &&q.IdOrdenCompra_ext == info.IdOrdenCompraExt
                        && q.Secuencia==item.Secuencia
                        && q.IdProducto==item.IdProducto);
                        if (Entity == null)
                            return false;
                        detalle.od_cantidad_recepcion = item.od_cantidad_recepcion;
                        Context.SaveChanges();
                    }

                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }

        public bool modificarDB(imp_orden_compra_ext_recepcion_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_orden_compra_ext_recepcion Entity = Context.imp_orden_compra_ext_recepcion.FirstOrDefault(q => q.IdRecepcion == info.IdRecepcion);
                    if (Entity == null) return false;
                    Entity.or_fecha = info.or_fecha;
                    Entity.or_observacion = info.or_observacion;
                    Entity.IdEmpresa_oc = info.IdEmpresa;
                    Entity.IdOrdenCompraExt = info.IdOrdenCompraExt;
                    Entity.IdEmpresa_inv = info.IdEmpresa;
                    Entity.IdSucursal_inv = info.IdSucursal_inv;
                    Entity.IdMovi_inven_tipo_inv = info.IdMovi_inven_tipo_inv;
                    Entity.IdNumMovi_inv = info.IdNumMovi_inv;
                    Entity.IdBodega = info.IdBodega;
                    Entity.IdMotivo_Inv = info.IdMotivo_Inv;

                    Context.SaveChanges();
                    foreach (var item in info.lst_detalle)
                    {
                        imp_orden_compra_ext_det detalle = Context.imp_orden_compra_ext_det.FirstOrDefault(q =>
                       q.IdEmpresa == item.IdEmpresa
                       && q.IdOrdenCompra_ext == info.IdOrdenCompraExt
                       && q.Secuencia == item.Secuencia
                       && q.IdProducto == item.IdProducto);
                        if (Entity == null)
                            return false;
                        detalle.od_cantidad_recepcion = item.od_cantidad_recepcion;
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
        public bool anularDB(imp_orden_compra_ext_recepcion_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_orden_compra_ext_recepcion Entity = Context.imp_orden_compra_ext_recepcion.FirstOrDefault(q => q.IdRecepcion == info.IdRecepcion);
                    if (Entity == null) return false;
                    Entity.estado = info.estado = false;
                    Entity.fecha_anulacion = DateTime.Now;
                    Context.SaveChanges();

                    foreach (var item in info.lst_detalle)
                    {
                        imp_orden_compra_ext_det detalle = Context.imp_orden_compra_ext_det.FirstOrDefault(q =>
                       q.IdEmpresa == item.IdEmpresa
                       && q.IdOrdenCompra_ext == info.IdOrdenCompraExt
                       && q.Secuencia == item.Secuencia
                       && q.IdProducto == item.IdProducto);
                        if (Entity == null)
                            return false;
                        detalle.od_cantidad_recepcion = 0;
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
