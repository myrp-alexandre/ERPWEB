using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_parametro_Data
    {
        public in_parametro_Info get_info(int IdEmpresa)
        {
            try
            {
                in_parametro_Info info = new in_parametro_Info();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_parametro Entity = Context.in_parametro.FirstOrDefault(q => q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new in_parametro_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdMovi_inven_tipo_egresoBodegaOrigen = Entity.IdMovi_inven_tipo_egresoBodegaOrigen,
                        IdMovi_inven_tipo_ingresoBodegaDestino = Entity.IdMovi_inven_tipo_ingresoBodegaDestino,
                        Maneja_Stock_Negativo = Entity.Maneja_Stock_Negativo,
                        Usuario_Escoge_Motivo = Entity.Usuario_Escoge_Motivo,
                        IdMovi_inven_tipo_egresoAjuste = Entity.IdMovi_inven_tipo_egresoAjuste,
                        IdMovi_inven_tipo_ingresoAjuste = Entity.IdMovi_inven_tipo_ingresoAjuste,
                        IdCtaCble_Inven = Entity.IdCtaCble_Inven,
                        IdCtaCble_CostoInven = Entity.IdCtaCble_CostoInven,
                        IdTipoCbte_CostoInven = Entity.IdTipoCbte_CostoInven,
                        IdTipoCbte_CostoInven_Reverso = Entity.IdTipoCbte_CostoInven_Reverso,
                        IdMovi_Inven_tipo_x_anu_Ing = Entity.IdMovi_Inven_tipo_x_anu_Ing,
                        IdMovi_Inven_tipo_x_anu_Egr = Entity.IdMovi_Inven_tipo_x_anu_Egr,
                        IdMovi_Inven_tipo_Ing_Ajust_fis_x_defa = Entity.IdMovi_Inven_tipo_Ing_Ajust_fis_x_defa,
                        IdMovi_Inven_tipo_Egr_Ajust_fis_x_defa = Entity.IdMovi_Inven_tipo_Egr_Ajust_fis_x_defa,
                        ApruebaAjusteFisicoAuto = Entity.ApruebaAjusteFisicoAuto,
                        IdEstadoAproba_x_Ing = Entity.IdEstadoAproba_x_Ing,
                        IdEstadoAproba_x_Egr = Entity.IdEstadoAproba_x_Egr,
                        IdMovi_Inven_tipo_x_Dev_Inv_x_Ing = Entity.IdMovi_Inven_tipo_x_Dev_Inv_x_Ing,
                        IdMovi_Inven_tipo_x_Dev_Inv_x_Erg = Entity.IdMovi_Inven_tipo_x_Dev_Inv_x_Erg,
                        P_Fecha_para_contabilizacion_ingr_egr = Entity.P_Fecha_para_contabilizacion_ingr_egr,
                        P_se_valida_parametrizacion_x_producto = Entity.P_se_valida_parametrizacion_x_producto == null ? false : Convert.ToBoolean(Entity.P_se_valida_parametrizacion_x_producto),
                        P_Al_Conta_CtaInven_Buscar_en = Entity.P_Al_Conta_CtaInven_Buscar_en,
                        P_Al_Conta_CtaCosto_Buscar_en = Entity.P_Al_Conta_CtaCosto_Buscar_en,
                        P_IdCtaCble_transitoria_transf_inven = Entity.P_IdCtaCble_transitoria_transf_inven,
                        P_IdProductoTipo_para_lote_0 = Entity.P_IdProductoTipo_para_lote_0,
                        P_se_crea_lote_0_al_crear_producto_matriz = Entity.P_se_crea_lote_0_al_crear_producto_matriz == null ? false : Convert.ToBoolean(Entity.P_se_crea_lote_0_al_crear_producto_matriz),
                        IdMovi_inven_tipo_x_distribucion_ing = Entity.IdMovi_inven_tipo_x_distribucion_ing,
                        IdMovi_inven_tipo_x_distribucion_egr = Entity.IdMovi_inven_tipo_x_distribucion_egr,
                        P_IdMovi_inven_tipo_default_ing = Entity.P_IdMovi_inven_tipo_default_ing,
                        P_IdMovi_inven_tipo_default_egr = Entity.P_IdMovi_inven_tipo_default_egr,
                        P_IdMovi_inven_tipo_ingreso_x_compra = Entity.P_IdMovi_inven_tipo_ingreso_x_compra,
                        P_Dias_menores_alerta_desde_fecha_actual_rojo = Entity.P_Dias_menores_alerta_desde_fecha_actual_rojo,
                        P_Dias_menores_alerta_desde_fecha_actual_amarillo = Entity.P_Dias_menores_alerta_desde_fecha_actual_amarillo,
                        Maneja_Stock_Negativo_bool = Entity.Maneja_Stock_Negativo == "S" ? true : false,
                        Usuario_Escoge_Motivo_bool = Entity.Usuario_Escoge_Motivo == "S" ? true : false,
                        ApruebaAjusteFisicoAuto_bool = Entity.ApruebaAjusteFisicoAuto == "S" ? true : false,
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_parametro_Info info)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_parametro Entity = Context.in_parametro.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null)
                    {
                        Entity = new in_parametro
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdMovi_inven_tipo_egresoBodegaOrigen = info.IdMovi_inven_tipo_egresoBodegaOrigen,
                            IdMovi_inven_tipo_ingresoBodegaDestino = info.IdMovi_inven_tipo_ingresoBodegaDestino,
                            Maneja_Stock_Negativo = info.Maneja_Stock_Negativo_bool == true ? "S" : "N",
                            Usuario_Escoge_Motivo = info.Usuario_Escoge_Motivo_bool == true ? "S" : "N",
                            IdMovi_inven_tipo_egresoAjuste = info.IdMovi_inven_tipo_egresoAjuste,
                            IdMovi_inven_tipo_ingresoAjuste = info.IdMovi_inven_tipo_ingresoAjuste,
                            IdCtaCble_Inven = info.IdCtaCble_Inven,
                            IdCtaCble_CostoInven = info.IdCtaCble_CostoInven,
                            IdTipoCbte_CostoInven = info.IdTipoCbte_CostoInven,
                            IdTipoCbte_CostoInven_Reverso = info.IdTipoCbte_CostoInven_Reverso,
                            IdMovi_Inven_tipo_x_anu_Ing = info.IdMovi_Inven_tipo_x_anu_Ing,
                            IdMovi_Inven_tipo_x_anu_Egr = info.IdMovi_Inven_tipo_x_anu_Egr,
                            IdMovi_Inven_tipo_Ing_Ajust_fis_x_defa = info.IdMovi_Inven_tipo_Ing_Ajust_fis_x_defa,
                            IdMovi_Inven_tipo_Egr_Ajust_fis_x_defa = info.IdMovi_Inven_tipo_Egr_Ajust_fis_x_defa,
                            ApruebaAjusteFisicoAuto = info.ApruebaAjusteFisicoAuto_bool == true ? "S" : "N",
                            IdEstadoAproba_x_Ing = info.IdEstadoAproba_x_Ing,
                            IdEstadoAproba_x_Egr = info.IdEstadoAproba_x_Egr,
                            IdMovi_Inven_tipo_x_Dev_Inv_x_Ing = info.IdMovi_Inven_tipo_x_Dev_Inv_x_Ing,
                            IdMovi_Inven_tipo_x_Dev_Inv_x_Erg = info.IdMovi_Inven_tipo_x_Dev_Inv_x_Erg,
                            P_Fecha_para_contabilizacion_ingr_egr = info.P_Fecha_para_contabilizacion_ingr_egr,
                            P_se_valida_parametrizacion_x_producto = info.P_se_valida_parametrizacion_x_producto,
                            P_Al_Conta_CtaInven_Buscar_en = info.P_Al_Conta_CtaInven_Buscar_en,
                            P_Al_Conta_CtaCosto_Buscar_en = info.P_Al_Conta_CtaCosto_Buscar_en,
                            P_IdCtaCble_transitoria_transf_inven = info.P_IdCtaCble_transitoria_transf_inven,
                            P_IdProductoTipo_para_lote_0 = info.P_IdProductoTipo_para_lote_0,
                            P_se_crea_lote_0_al_crear_producto_matriz = info.P_se_crea_lote_0_al_crear_producto_matriz,
                            IdMovi_inven_tipo_x_distribucion_ing = info.IdMovi_inven_tipo_x_distribucion_ing,
                            IdMovi_inven_tipo_x_distribucion_egr = info.IdMovi_inven_tipo_x_distribucion_egr,
                            P_IdMovi_inven_tipo_default_ing = info.P_IdMovi_inven_tipo_default_ing,
                            P_IdMovi_inven_tipo_default_egr = info.P_IdMovi_inven_tipo_default_egr,
                            P_IdMovi_inven_tipo_ingreso_x_compra = info.P_IdMovi_inven_tipo_ingreso_x_compra,
                            P_Dias_menores_alerta_desde_fecha_actual_rojo = info.P_Dias_menores_alerta_desde_fecha_actual_rojo,
                            P_Dias_menores_alerta_desde_fecha_actual_amarillo = info.P_Dias_menores_alerta_desde_fecha_actual_amarillo,                            
                        };
                        Context.in_parametro.Add(Entity);
                    }
                    else
                    {
                        Entity.IdMovi_inven_tipo_egresoBodegaOrigen = info.IdMovi_inven_tipo_egresoBodegaOrigen;
                        Entity.IdMovi_inven_tipo_ingresoBodegaDestino = info.IdMovi_inven_tipo_ingresoBodegaDestino;
                        Entity.Maneja_Stock_Negativo = info.Maneja_Stock_Negativo_bool == true ? "S" : "N";
                        Entity.Usuario_Escoge_Motivo = info.Usuario_Escoge_Motivo_bool == true ? "S" : "N";
                        Entity.IdMovi_inven_tipo_egresoAjuste = info.IdMovi_inven_tipo_egresoAjuste;
                        Entity.IdMovi_inven_tipo_ingresoAjuste = info.IdMovi_inven_tipo_ingresoAjuste;
                        Entity.IdCtaCble_Inven = info.IdCtaCble_Inven;
                        Entity.IdCtaCble_CostoInven = info.IdCtaCble_CostoInven;
                        Entity.IdTipoCbte_CostoInven = info.IdTipoCbte_CostoInven;
                        Entity.IdTipoCbte_CostoInven_Reverso = info.IdTipoCbte_CostoInven_Reverso;
                        Entity.IdMovi_Inven_tipo_x_anu_Ing = info.IdMovi_Inven_tipo_x_anu_Ing;
                        Entity.IdMovi_Inven_tipo_x_anu_Egr = info.IdMovi_Inven_tipo_x_anu_Egr;
                        Entity.IdMovi_Inven_tipo_Ing_Ajust_fis_x_defa = info.IdMovi_Inven_tipo_Ing_Ajust_fis_x_defa;
                        Entity.IdMovi_Inven_tipo_Egr_Ajust_fis_x_defa = info.IdMovi_Inven_tipo_Egr_Ajust_fis_x_defa;
                        Entity.ApruebaAjusteFisicoAuto = info.ApruebaAjusteFisicoAuto_bool == true ? "S" : "N";
                        Entity.IdEstadoAproba_x_Ing = info.IdEstadoAproba_x_Ing;
                        Entity.IdEstadoAproba_x_Egr = info.IdEstadoAproba_x_Egr;
                        Entity.IdMovi_Inven_tipo_x_Dev_Inv_x_Ing = info.IdMovi_Inven_tipo_x_Dev_Inv_x_Ing;
                        Entity.IdMovi_Inven_tipo_x_Dev_Inv_x_Erg = info.IdMovi_Inven_tipo_x_Dev_Inv_x_Erg;
                        Entity.P_Fecha_para_contabilizacion_ingr_egr = info.P_Fecha_para_contabilizacion_ingr_egr;
                        Entity.P_se_valida_parametrizacion_x_producto = info.P_se_valida_parametrizacion_x_producto;
                        Entity.P_Al_Conta_CtaInven_Buscar_en = info.P_Al_Conta_CtaInven_Buscar_en;
                        Entity.P_Al_Conta_CtaCosto_Buscar_en = info.P_Al_Conta_CtaCosto_Buscar_en;
                        Entity.P_IdCtaCble_transitoria_transf_inven = info.P_IdCtaCble_transitoria_transf_inven;
                        Entity.P_IdProductoTipo_para_lote_0 = info.P_IdProductoTipo_para_lote_0;
                        Entity.P_se_crea_lote_0_al_crear_producto_matriz = info.P_se_crea_lote_0_al_crear_producto_matriz;
                        Entity.IdMovi_inven_tipo_x_distribucion_ing = info.IdMovi_inven_tipo_x_distribucion_ing;
                        Entity.IdMovi_inven_tipo_x_distribucion_egr = info.IdMovi_inven_tipo_x_distribucion_egr;
                        Entity.P_IdMovi_inven_tipo_default_ing = info.P_IdMovi_inven_tipo_default_ing;
                        Entity.P_IdMovi_inven_tipo_default_egr = info.P_IdMovi_inven_tipo_default_egr;
                        Entity.P_IdMovi_inven_tipo_ingreso_x_compra = info.P_IdMovi_inven_tipo_ingreso_x_compra;
                        Entity.P_Dias_menores_alerta_desde_fecha_actual_rojo = info.P_Dias_menores_alerta_desde_fecha_actual_rojo;
                        Entity.P_Dias_menores_alerta_desde_fecha_actual_amarillo = info.P_Dias_menores_alerta_desde_fecha_actual_amarillo;
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
    }
}
