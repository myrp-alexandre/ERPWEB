using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
    public class fa_parametro_Data
    {
        public fa_parametro_Info get_info(int IdEmpresa)
        {
            try
            {
                fa_parametro_Info info = new fa_parametro_Info();
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_parametro Entity = Context.fa_parametro.FirstOrDefault(q => q.IdEmpresa == IdEmpresa);
                    if (Entity != null)
                        info = new fa_parametro_Info
                        {
                            IdEmpresa = Entity.IdEmpresa,
                            IdMovi_inven_tipo_Factura = Entity.IdMovi_inven_tipo_Factura,
                            pa_porc_max_total_item_x_despa_Guia = Entity.pa_porc_max_total_item_x_despa_Guia,
                            IdDepartamento_x_DevVta = Entity.IdDepartamento_x_DevVta,
                            IdMovi_inven_tipo_Dev_Vta = Entity.IdMovi_inven_tipo_Dev_Vta,
                            IdMovi_inven_tipo_Dev_Vta_Anulacion = Entity.IdMovi_inven_tipo_Dev_Vta_Anulacion,
                            IdMovi_inven_tipo_Factura_Anulacion = Entity.IdMovi_inven_tipo_Factura_Anulacion,
                            Tipo_NC_x_DevVta = Entity.Tipo_NC_x_DevVta,
                            IdTipoCbteCble_Factura = Entity.IdTipoCbteCble_Factura,
                            IdTipoCbteCble_Factura_Costo_VTA = Entity.IdTipoCbteCble_Factura_Costo_VTA,
                            IdTipoCbteCble_Factura_Costo_VTA_Reverso = Entity.IdTipoCbteCble_Factura_Costo_VTA_Reverso,
                            IdTipoCbteCble_Factura_Reverso = Entity.IdTipoCbteCble_Factura_Reverso,
                            IdTipoCbteCble_NC = Entity.IdTipoCbteCble_NC,
                            IdTipoCbteCble_NC_Reverso = Entity.IdTipoCbteCble_NC_Reverso,
                            IdTipoCbteCble_ND = Entity.IdTipoCbteCble_ND,
                            IdTipoCbteCble_ND_Reverso = Entity.IdTipoCbteCble_ND_Reverso,
                            pa_IdTipoNota_NC_x_Anulacion = Entity.pa_IdTipoNota_NC_x_Anulacion,
                            IdCtaCble_SubTotal_Vtas_x_Default = Entity.IdCtaCble_SubTotal_Vtas_x_Default,
                            SeImprimiGuiaRemiAuto = Entity.SeImprimiGuiaRemiAuto,
                            NumeroDeItemFact = Entity.NumeroDeItemFact,
                            NumeroDeItemProforma = Entity.NumeroDeItemProforma,
                            IdCaja_Default_Factura = Entity.IdCaja_Default_Factura,
                            IdCtaCble_CXC_Vtas_x_Default = Entity.IdCtaCble_CXC_Vtas_x_Default,
                            IdCtaCble_IVA = Entity.IdCtaCble_IVA,
                            IdCtaCble_x_anticipo_cliente = Entity.IdCtaCble_x_anticipo_cliente,
                            pa_IdCtaCble_descuento = Entity.pa_IdCtaCble_descuento,
                            File_Reporte_FacturaDiseño = Entity.File_Reporte_FacturaDiseño,
                            File_Reporte_Nota_CRED_DEB = Entity.File_Reporte_Nota_CRED_DEB,
                            pa_Contabiliza_descuento = Entity.pa_Contabiliza_descuento,
                            pa_ruta_descarga_xml_fac_elct = Entity.pa_ruta_descarga_xml_fac_elct,
                            pa_X_Defecto_la_factura_es_cbte_elect = Entity.pa_X_Defecto_la_factura_es_cbte_elect,
                            pa_X_Defecto_la_guia_es_cbte_elect = Entity.pa_X_Defecto_la_guia_es_cbte_elect,
                            pa_X_Defecto_la_NC_es_cbte_elect = Entity.pa_X_Defecto_la_NC_es_cbte_elect,
                            pa_X_Defecto_la_ND_es_cbte_elect = Entity.pa_X_Defecto_la_ND_es_cbte_elect,
                            clave_desbloqueo_precios = Entity.clave_desbloqueo_precios,
                            TipoCobroDafaultFactu = Entity.TipoCobroDafaultFactu
                        };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(fa_parametro_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_parametro Entity = Context.fa_parametro.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null)
                    {
                        Entity = new fa_parametro
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdMovi_inven_tipo_Factura = info.IdMovi_inven_tipo_Factura,
                            IdTipoCbteCble_Factura = info.IdTipoCbteCble_Factura,
                            NumeroDeItemFact = info.NumeroDeItemFact,
                            NumeroDeItemProforma = info.NumeroDeItemProforma,
                            IdCaja_Default_Factura = info.IdCaja_Default_Factura,
                            IdMovi_inven_tipo_Dev_Vta = info.IdMovi_inven_tipo_Dev_Vta,
                            Tipo_NC_x_DevVta = info.Tipo_NC_x_DevVta,
                            IdTipoCbteCble_NC = info.IdTipoCbteCble_NC,
                            IdTipoCbteCble_ND = info.IdTipoCbteCble_ND,


                            /*     pa_porc_max_total_item_x_despa_Guia = info.pa_porc_max_total_item_x_despa_Guia,
                                   IdDepartamento_x_DevVta = info.IdDepartamento_x_DevVta,
                                   IdMovi_inven_tipo_Dev_Vta_Anulacion = info.IdMovi_inven_tipo_Dev_Vta_Anulacion,
                                   IdMovi_inven_tipo_Factura_Anulacion = info.IdMovi_inven_tipo_Factura_Anulacion,
                                   IdTipoCbteCble_Factura_Costo_VTA = info.IdTipoCbteCble_Factura_Costo_VTA,
                                   IdTipoCbteCble_Factura_Costo_VTA_Reverso = info.IdTipoCbteCble_Factura_Costo_VTA_Reverso,
                                   IdTipoCbteCble_Factura_Reverso = info.IdTipoCbteCble_Factura_Reverso,
                                   IdTipoCbteCble_NC_Reverso = info.IdTipoCbteCble_NC_Reverso,
                                   IdTipoCbteCble_ND_Reverso = info.IdTipoCbteCble_ND_Reverso,
                                   pa_IdTipoNota_NC_x_Anulacion = info.pa_IdTipoNota_NC_x_Anulacion,
                                   IdCtaCble_SubTotal_Vtas_x_Default = info.IdCtaCble_SubTotal_Vtas_x_Default,
                                   SeImprimiGuiaRemiAuto = info.SeImprimiGuiaRemiAuto,
                                   IdCtaCble_CXC_Vtas_x_Default = info.IdCtaCble_CXC_Vtas_x_Default,
                                   IdCtaCble_IVA = info.IdCtaCble_IVA,
                                   IdCtaCble_x_anticipo_cliente = info.IdCtaCble_x_anticipo_cliente,
                                   pa_IdCtaCble_descuento = info.pa_IdCtaCble_descuento,
                                   File_Reporte_FacturaDiseño = info.File_Reporte_FacturaDiseño,
                                   File_Reporte_Nota_CRED_DEB = info.File_Reporte_Nota_CRED_DEB,
                                   pa_Contabiliza_descuento = info.pa_Contabiliza_descuento,
                                   pa_ruta_descarga_xml_fac_elct = info.pa_ruta_descarga_xml_fac_elct,
                                   pa_X_Defecto_la_factura_es_cbte_elect = info.pa_X_Defecto_la_factura_es_cbte_elect,
                                   pa_X_Defecto_la_guia_es_cbte_elect = info.pa_X_Defecto_la_guia_es_cbte_elect,
                                   pa_X_Defecto_la_NC_es_cbte_elect = info.pa_X_Defecto_la_NC_es_cbte_elect,
                                   pa_X_Defecto_la_ND_es_cbte_elect = info.pa_X_Defecto_la_ND_es_cbte_elect,
                                   clave_desbloqueo_precios = info.clave_desbloqueo_precios,
                                   TipoCobroDafaultFactu = info.TipoCobroDafaultFactu*/
                        };
                        Context.fa_parametro.Add(Entity);
                    }
                    else
                    {
                        Entity.IdMovi_inven_tipo_Factura = info.IdMovi_inven_tipo_Factura;
                        Entity.IdTipoCbteCble_Factura = info.IdTipoCbteCble_Factura;
                        Entity.NumeroDeItemFact = info.NumeroDeItemFact;
                        Entity.NumeroDeItemProforma = info.NumeroDeItemProforma;
                        Entity.IdTipoCbteCble_NC = info.IdTipoCbteCble_NC;
                        Entity.IdTipoCbteCble_ND = info.IdTipoCbteCble_ND;
                        Entity.IdCaja_Default_Factura = info.IdCaja_Default_Factura;
                        Entity.Tipo_NC_x_DevVta = info.Tipo_NC_x_DevVta;
                        Entity.IdMovi_inven_tipo_Dev_Vta = info.IdMovi_inven_tipo_Dev_Vta;


                    /*    Entity.pa_porc_max_total_item_x_despa_Guia = info.pa_porc_max_total_item_x_despa_Guia;
                        Entity.IdDepartamento_x_DevVta = info.IdDepartamento_x_DevVta;
                        Entity.IdMovi_inven_tipo_Dev_Vta_Anulacion = info.IdMovi_inven_tipo_Dev_Vta_Anulacion;
                        Entity.IdMovi_inven_tipo_Factura_Anulacion = info.IdMovi_inven_tipo_Factura_Anulacion;
                        Entity.IdTipoCbteCble_Factura_Costo_VTA = info.IdTipoCbteCble_Factura_Costo_VTA;
                        Entity.IdTipoCbteCble_Factura_Costo_VTA_Reverso = info.IdTipoCbteCble_Factura_Costo_VTA_Reverso;
                        Entity.IdTipoCbteCble_Factura_Reverso = info.IdTipoCbteCble_Factura_Reverso;
                        Entity.IdTipoCbteCble_NC_Reverso = info.IdTipoCbteCble_NC_Reverso;
                        Entity.IdTipoCbteCble_ND_Reverso = info.IdTipoCbteCble_ND_Reverso;
                        Entity.pa_IdTipoNota_NC_x_Anulacion = info.pa_IdTipoNota_NC_x_Anulacion;
                        Entity.IdCtaCble_SubTotal_Vtas_x_Default = info.IdCtaCble_SubTotal_Vtas_x_Default;
                        Entity.SeImprimiGuiaRemiAuto = info.SeImprimiGuiaRemiAuto;
                        Entity.IdCtaCble_CXC_Vtas_x_Default = info.IdCtaCble_CXC_Vtas_x_Default;
                        Entity.IdCtaCble_IVA = info.IdCtaCble_IVA;
                        Entity.IdCtaCble_x_anticipo_cliente = info.IdCtaCble_x_anticipo_cliente;
                        Entity.pa_IdCtaCble_descuento = info.pa_IdCtaCble_descuento;
                        Entity.File_Reporte_FacturaDiseño = info.File_Reporte_FacturaDiseño;
                        Entity.File_Reporte_Nota_CRED_DEB = info.File_Reporte_Nota_CRED_DEB;
                        Entity.pa_Contabiliza_descuento = info.pa_Contabiliza_descuento;
                        Entity.pa_ruta_descarga_xml_fac_elct = info.pa_ruta_descarga_xml_fac_elct;
                        Entity.pa_X_Defecto_la_factura_es_cbte_elect = info.pa_X_Defecto_la_factura_es_cbte_elect;
                        Entity.pa_X_Defecto_la_guia_es_cbte_elect = info.pa_X_Defecto_la_guia_es_cbte_elect;
                        Entity.pa_X_Defecto_la_NC_es_cbte_elect = info.pa_X_Defecto_la_NC_es_cbte_elect;
                        Entity.pa_X_Defecto_la_ND_es_cbte_elect = info.pa_X_Defecto_la_ND_es_cbte_elect;
                        Entity.clave_desbloqueo_precios = info.clave_desbloqueo_precios;
                        Entity.TipoCobroDafaultFactu = info.TipoCobroDafaultFactu;*/
                        

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
