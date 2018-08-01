using Core.Erp.Info.Importacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Importacion
{
   public class imp_liquidacion_det_x_imp_orden_compra_ext_Data
    {

        public List<imp_liquidacion_det_x_imp_orden_compra_ext_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime Fecha_fin)
        {
            try
            {
                List<imp_liquidacion_det_x_imp_orden_compra_ext_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.vwimp_liquidacion_det_x_imp_orden_compra_ext
                             where q.IdEmpresa == IdEmpresa
                             && q.oe_fecha >= fecha_inicio
                             && q.oe_fecha <= Fecha_fin
                             select new imp_liquidacion_det_x_imp_orden_compra_ext_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdLiquidacion=q.IdLiquidacion,
                                 IdEmpresa_oe=q.IdEmpresa_oe,
                                 IdOrdenCompra_ext=q.IdOrdenCompra_ext,
                                 observacion=q.observacion,
                                 oe_observacion=q.oe_observacion,
                                 oe_fecha=q.oe_fecha,
                                 pe_cedulaRuc=q.pe_cedulaRuc,
                                 pe_nombreCompleto=q.pe_nombreCompleto,
                                 IdMoneda_destino=q.IdMoneda_destino,
                                 IdMoneda_origen=q.IdMoneda_origen,
                                 Estado_cierre=q.Estado_cierre,
                                 IdPais_embarque=q.IdPais_embarque,
                                 IdCiudad_destino=q.IdCiudad_destino,
                                 IdCatalogo_via=q.IdCatalogo_via,
                                 IdCatalogo_forma_pago=q.IdCatalogo_forma_pago


                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public imp_liquidacion_det_x_imp_orden_compra_ext_Info get_info(int IdEmpresa, decimal IdLiquidacion)
        {
            try
            {
                imp_liquidacion_det_x_imp_orden_compra_ext_Info info = new imp_liquidacion_det_x_imp_orden_compra_ext_Info();
                using (Entities_importacion Context = new Entities_importacion())
                {
                    vwimp_liquidacion_det_x_imp_orden_compra_ext Entity = Context.vwimp_liquidacion_det_x_imp_orden_compra_ext.FirstOrDefault(q => q.IdLiquidacion == IdLiquidacion && q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new imp_liquidacion_det_x_imp_orden_compra_ext_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdLiquidacion = Entity.IdLiquidacion,
                        IdEmpresa_oe = Entity.IdEmpresa_oe,
                        IdOrdenCompra_ext = Entity.IdOrdenCompra_ext,
                        observacion = Entity.observacion,
                        oe_observacion = Entity.oe_observacion,
                        oe_fecha = Entity.oe_fecha,
                        pe_cedulaRuc = Entity.pe_cedulaRuc,
                        pe_nombreCompleto = Entity.pe_nombreCompleto,
                        IdMoneda_destino = Entity.IdMoneda_destino,
                        IdMoneda_origen = Entity.IdMoneda_origen,
                        Estado_cierre = Entity.Estado_cierre,
                        IdPais_embarque = Entity.IdPais_embarque,
                        IdCiudad_destino = Entity.IdCiudad_destino,
                        IdCatalogo_via = Entity.IdCatalogo_via,
                        IdCatalogo_forma_pago = Entity.IdCatalogo_forma_pago
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
                    var lst = from q in Context.imp_liquidacion_det_x_imp_orden_compra_ext
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdLiquidacion) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(imp_liquidacion_det_x_imp_orden_compra_ext_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_liquidacion_det_x_imp_orden_compra_ext Entity = new imp_liquidacion_det_x_imp_orden_compra_ext
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdLiquidacion = info.IdLiquidacion,
                        IdEmpresa_oe = info.IdEmpresa_oe,
                        IdOrdenCompra_ext = info.IdOrdenCompra_ext,
                        observacion = info.observacion,                      

                    };
                    Context.imp_liquidacion_det_x_imp_orden_compra_ext.Add(Entity);
                    foreach (var item in info.lst_gastos_asignados)
                    {
                        Context.imp_orden_compra_ext_ct_cbteble_det_gastos.Add(new imp_orden_compra_ext_ct_cbteble_det_gastos
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdCbteCble = item.IdCbteCble,
                            IdEmpresa_ct = item.IdEmpresa_ct,
                            IdGasto_tipo = item.IdGasto_tipo,
                            IdOrdenCompra_ext = item.IdOrdenCompra_ext,
                            IdTipoCbte = item.IdTipoCbte
                        });
                      
                    }
                    Context.SaveChanges();

                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }

        public bool modificarDB(imp_liquidacion_det_x_imp_orden_compra_ext_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_liquidacion_det_x_imp_orden_compra_ext Entity = Context.imp_liquidacion_det_x_imp_orden_compra_ext.FirstOrDefault(q => q.IdLiquidacion == info.IdLiquidacion);
                    if (Entity == null) return false;
                    Entity.observacion = info.observacion;

                    foreach (var item in info.lst_gastos_asignados)
                    {
                        Context.imp_orden_compra_ext_ct_cbteble_det_gastos.Add(new imp_orden_compra_ext_ct_cbteble_det_gastos
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdCbteCble = item.IdCbteCble,
                            IdEmpresa_ct = item.IdEmpresa_ct,
                            IdGasto_tipo = item.IdGasto_tipo,
                            IdOrdenCompra_ext = item.IdOrdenCompra_ext,
                            IdTipoCbte = item.IdTipoCbte
                        });

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
        public bool anularDB(imp_liquidacion_det_x_imp_orden_compra_ext_Info info)
        {
            try
            {
                using (Entities_importacion Context = new Entities_importacion())
                {
                    imp_liquidacion_det_x_imp_orden_compra_ext Entity = Context.imp_liquidacion_det_x_imp_orden_compra_ext.FirstOrDefault(q => q.IdLiquidacion == info.IdLiquidacion);
                    if (Entity == null)
                        return false;
                    Context.SaveChanges();
                    string sql = "delete imp_orden_compra_ext_ct_cbteble_det_gastos where IdEmpresa='"+info.IdEmpresa+ "' and IdLiquidacion='"+info.IdLiquidacion+"'";
                    Context.Database.ExecuteSqlCommand(sql);  
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
