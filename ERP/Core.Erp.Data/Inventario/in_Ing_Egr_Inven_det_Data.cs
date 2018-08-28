using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Inventario
{
    public class in_Ing_Egr_Inven_det_Data
    {
        public List<in_Ing_Egr_Inven_det_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                List<in_Ing_Egr_Inven_det_Info> Lista;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_Ing_Egr_Inven_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdEmpresa==IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                             && q.IdNumMovi == IdNumMovi
                             select new in_Ing_Egr_Inven_det_Info
                             {

                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,
                                 IdBodega = q.IdBodega,
                                 dm_cantidad = q.dm_cantidad,
                                 dm_observacion = q.dm_observacion,
                                 IdMotivo_Inv = q.IdMotivo_Inv,
                                 IdEstadoAproba = q.IdEstadoAproba,
                                 IdOrdenCompra = q.IdOrdenCompra,
                                 IdProducto = q.IdProducto,
                                 IdUnidadMedida = q.IdUnidadMedida,
                                 IdPunto_cargo = q.IdPunto_cargo,
                                 IdPunto_cargo_grupo = q.IdPunto_cargo_grupo,
                                 mv_costo = q.mv_costo,
                                 Secuencia = q.Secuencia,

                                 IdSucursal_inv = q.IdSucursal_inv,
                                 IdSucursal_oc = q.IdSucursal_oc,
                                 IdEmpresa_inv = q.IdEmpresa_inv,
                                 IdEmpresa_oc = q.IdEmpresa_oc,
                                 IdBodega_inv = q.IdBodega_inv,
                                 IdMovi_inven_tipo_inv = q.IdMovi_inven_tipo_inv,
                                 IdNumMovi_inv = q.IdNumMovi_inv,
                                 dm_cantidad_sinConversion = q.dm_cantidad_sinConversion,
                                 IdUnidadMedida_sinConversion = q.IdUnidadMedida_sinConversion,
                                 mv_costo_sinConversion = q.mv_costo_sinConversion,
                                 secuencia_inv = q.secuencia_inv,
                                 Secuencia_oc = q.Secuencia_oc,
                                 pr_descripcion = q.pr_descripcion,

                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote,
                                 nom_presentacion = q.nom_presentacion

                             }).ToList();
                }
                Lista.ForEach(V =>
                {
                    V.pr_descripcion = V.pr_descripcion + " " + V.nom_presentacion + " - " + V.lote_num_lote + " - " + (V.lote_fecha_vcto != null ? Convert.ToDateTime(V.lote_fecha_vcto).ToString("dd/MM/yyyy") : "");
                    V.dm_cantidad_sinConversion = Math.Abs(V.dm_cantidad_sinConversion);
                    V.dm_cantidad = Math.Abs(V.dm_cantidad);
                });
                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public in_Ing_Egr_Inven_det_Info get_info(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                in_Ing_Egr_Inven_det_Info info = new in_Ing_Egr_Inven_det_Info();
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Ing_Egr_Inven_det Entity = Context.in_Ing_Egr_Inven_det.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdMovi_inven_tipo == IdMovi_inven_tipo && q.IdNumMovi == IdNumMovi);
                    if (Entity == null) return null;
                    info = new in_Ing_Egr_Inven_det_Info
                    {

                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        IdMovi_inven_tipo = Entity.IdMovi_inven_tipo,
                        IdNumMovi = Entity.IdNumMovi,
                        IdBodega = Entity.IdBodega,
                        dm_cantidad = Entity.dm_cantidad,
                        dm_observacion = Entity.dm_observacion,
                        IdMotivo_Inv = Entity.IdMotivo_Inv,
                        IdEstadoAproba = Entity.IdEstadoAproba,
                        IdOrdenCompra = Entity.IdOrdenCompra,
                        IdProducto = Entity.IdProducto,
                        IdUnidadMedida = Entity.IdUnidadMedida,
                        IdPunto_cargo = Entity.IdPunto_cargo,
                        IdPunto_cargo_grupo = Entity.IdPunto_cargo_grupo,
                        mv_costo = Entity.mv_costo,
                        Secuencia = Entity.Secuencia,

                        IdSucursal_inv = Entity.IdSucursal_inv,
                        IdSucursal_oc = Entity.IdSucursal_oc,
                        IdEmpresa_inv = Entity.IdEmpresa_inv,
                        IdEmpresa_oc = Entity.IdEmpresa_oc,
                        IdBodega_inv = Entity.IdBodega_inv,
                        IdMovi_inven_tipo_inv =Entity.IdMovi_inven_tipo_inv,
                        IdNumMovi_inv = Entity.IdNumMovi_inv,
                        dm_cantidad_sinConversion =Entity.dm_cantidad_sinConversion,
                        IdUnidadMedida_sinConversion = Entity.IdUnidadMedida_sinConversion,
                        mv_costo_sinConversion = Entity.mv_costo_sinConversion,
                        secuencia_inv = Entity.secuencia_inv,
                        Secuencia_oc = Entity.Secuencia_oc
                        
                    };
                }
                    return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_Ing_Egr_Inven_det_Info info)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Ing_Egr_Inven_det Entity = new in_Ing_Egr_Inven_det
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdMovi_inven_tipo = info.IdMovi_inven_tipo,
                        IdNumMovi = info.IdNumMovi,
                        Secuencia = info.Secuencia,
                        IdBodega = info.IdBodega,
                        IdProducto = info.IdProducto,                        
                        
                        IdCentroCosto = info.IdCentroCosto,
                        IdCentroCosto_sub_centro_costo = info.IdCentroCosto_sub_centro_costo,
                        IdPunto_cargo = info.IdPunto_cargo,
                        IdPunto_cargo_grupo = info.IdPunto_cargo_grupo,

                        dm_observacion = info.dm_observacion,
                        IdMotivo_Inv = info.IdMotivo_Inv,
                        IdEstadoAproba = info.IdEstadoAproba,
                        Motivo_Aprobacion = info.Motivo_Aprobacion,

                        IdEmpresa_oc = info.IdEmpresa_oc,
                        IdSucursal_oc = info.IdSucursal_oc,
                        IdOrdenCompra = info.IdOrdenCompra,
                        Secuencia_oc = info.Secuencia_oc,

                        IdEmpresa_inv = info.IdEmpresa_inv,
                        IdSucursal_inv = info.IdSucursal_inv,
                        IdBodega_inv = info.IdBodega_inv,
                        IdMovi_inven_tipo_inv = info.IdMovi_inven_tipo_inv,
                        IdNumMovi_inv = info.IdNumMovi_inv,
                        secuencia_inv = info.secuencia_inv,

                        dm_cantidad_sinConversion = info.dm_cantidad_sinConversion,
                        dm_cantidad = info.dm_cantidad = info.dm_cantidad_sinConversion,//
                        IdUnidadMedida_sinConversion = info.IdUnidadMedida_sinConversion,
                        IdUnidadMedida = info.IdUnidadMedida = info.IdUnidadMedida_sinConversion,//
                        mv_costo_sinConversion = info.mv_costo_sinConversion,
                        mv_costo = info.mv_costo =(double) info.mv_costo_sinConversion//,
                    };
                    Context.in_Ing_Egr_Inven_det.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                string sql = "Delete in_Ing_Egr_Inven_det where IdEmpresa = '" + IdEmpresa + "'and IdSucursal = '" + IdSucursal + "' and IdMovi_inven_tipo = '" + IdMovi_inven_tipo + "' and IdNumMovi = " + IdNumMovi;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Context.Database.ExecuteSqlCommand(sql);
                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }
        

    }
}
