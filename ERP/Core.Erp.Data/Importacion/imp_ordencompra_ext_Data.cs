using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Importacion;
namespace Core.Erp.Data.Importacion
{
   public class imp_ordencompra_ext_Data
    {
        public List<imp_ordencompra_ext_Info> get_list()
        {
            try
            {
                List<imp_ordencompra_ext_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.imp_orden_compra_ext
                             select new imp_ordencompra_ext_Info
                             {
                                 IdEmpresa=q.IdEmpresa,
                                 IdOrdenCompra_ext = q.IdOrdenCompra_ext,
                                 IdProveedor = q.IdProveedor,
                                 IdPais_origen = q.IdPais_origen,
                                 IdPais_embarque = q.IdPais_embarque,
                                 IdCiudad_destino = q.IdCiudad_destino,
                                 IdCatalogo_via = q.IdCatalogo_via,
                                 IdCatalogo_forma_pago = q.IdCatalogo_forma_pago,
                                 oe_fecha = q.oe_fecha,
                                 oe_fecha_llegada_est = q.oe_fecha_llegada_est,
                                 oe_fecha_embarque_est = q.oe_fecha_embarque_est,
                                 oe_fecha_desaduanizacion_est = q.oe_fecha_desaduanizacion_est,
                                 IdCtaCble_importacion = q.IdCtaCble_importacion,
                                 oe_observacion = q.oe_observacion,
                                 oe_codigo = q.oe_codigo,
                                 oe_valor_flete = q.oe_valor_flete,
                                 oe_valor_seguro = q.oe_valor_seguro,
                                 estado = q.estado,
                                 IdLiquidacion = q.IdLiquidacion,
                                 oe_fecha_llegada = q.oe_fecha_llegada,
                                 oe_fecha_embarque = q.oe_fecha_embarque,
                                 oe_fecha_desaduanizacion = q.oe_fecha_desaduanizacion

                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public imp_ordencompra_ext_Info get_info(int IdEmpresa, decimal IdOrdenCompra_ext)
        {
            try
            {
                imp_ordencompra_ext_Info info = new imp_ordencompra_ext_Info();
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_orden_compra_ext Entity = Context.imp_orden_compra_ext.FirstOrDefault( q => q.IdOrdenCompra_ext == IdOrdenCompra_ext && q.IdEmpresa==IdEmpresa);
                    if (Entity == null) return null;
                    info = new imp_ordencompra_ext_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdOrdenCompra_ext = Entity.IdOrdenCompra_ext,
                        IdProveedor = Entity.IdProveedor,
                        IdPais_origen = Entity.IdPais_origen,
                        IdPais_embarque = Entity.IdPais_embarque,
                        IdCiudad_destino = Entity.IdCiudad_destino,
                        IdCatalogo_via = Entity.IdCatalogo_via,
                        IdCatalogo_forma_pago = Entity.IdCatalogo_forma_pago,
                        oe_fecha = Entity.oe_fecha,
                        oe_fecha_llegada_est = Entity.oe_fecha_llegada_est,
                        oe_fecha_embarque = Entity.oe_fecha_embarque,
                        oe_fecha_desaduanizacion_est = Entity.oe_fecha_desaduanizacion_est,
                        IdCtaCble_importacion = Entity.IdCtaCble_importacion,
                        oe_observacion = Entity.oe_observacion,
                        oe_codigo = Entity.oe_codigo,
                        oe_valor_flete = Entity.oe_valor_flete,
                        oe_valor_seguro = Entity.oe_valor_seguro,
                        estado = Entity.estado,
                        IdLiquidacion = Entity.IdLiquidacion,
                        oe_fecha_llegada = Entity.oe_fecha_llegada,
                        oe_fecha_embarque_est = Entity.oe_fecha_embarque_est,
                        oe_fecha_desaduanizacion = Entity.oe_fecha_desaduanizacion
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id()
        {
            try
            {
                decimal ID = 1;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    var lst = from q in Context.imp_orden_compra_ext
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdOrdenCompra_ext) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(imp_ordencompra_ext_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_orden_compra_ext Entity = new imp_orden_compra_ext
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdOrdenCompra_ext = info.IdOrdenCompra_ext,
                        IdProveedor = info.IdProveedor,
                        IdPais_origen = info.IdPais_origen,
                        IdPais_embarque = info.IdPais_embarque,
                        IdCiudad_destino = info.IdCiudad_destino,
                        IdCatalogo_via = info.IdCatalogo_via,
                        IdCatalogo_forma_pago = info.IdCatalogo_forma_pago,
                        oe_fecha = info.oe_fecha,
                        oe_fecha_llegada_est = info.oe_fecha_llegada_est,
                        oe_fecha_embarque = info.oe_fecha_embarque,
                        oe_fecha_desaduanizacion_est = info.oe_fecha_desaduanizacion_est,
                        IdCtaCble_importacion = info.IdCtaCble_importacion,
                        oe_observacion = info.oe_observacion,
                        oe_codigo = info.oe_codigo,
                        oe_valor_flete = info.oe_valor_flete,
                        oe_valor_seguro = info.oe_valor_seguro,
                        estado = info.estado,
                        IdLiquidacion = info.IdLiquidacion,
                        oe_fecha_llegada = info.oe_fecha_llegada,
                        oe_fecha_embarque_est = info.oe_fecha_embarque_est,
                        oe_fecha_desaduanizacion = info.oe_fecha_desaduanizacion
                    };
                    Context.imp_orden_compra_ext.Add(Entity);
                    Context.imp_orden_compra_ext_det.Add(new imp_orden_compra_ext_det
                    {
                        
                    });

                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(imp_ordencompra_ext_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    //TRes el info del gasto - OK
                    imp_orden_compra_ext Entity = Context.imp_orden_compra_ext.FirstOrDefault(q => q.IdOrdenCompra_ext == info.IdOrdenCompra_ext);
                    if (Entity == null) return false;
                   
                  
                  
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(imp_ordencompra_ext_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_orden_compra_ext Entity = Context.imp_orden_compra_ext.FirstOrDefault(q => q.IdOrdenCompra_ext == info.IdOrdenCompra_ext);
                    if (Entity == null) return false;

                    Entity.estado = info.estado = false;

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
