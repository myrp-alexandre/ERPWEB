using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_parametros_Data
    {
        public Boolean modificarDB(cp_parametros_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar context = new Entities_cuentas_por_pagar())
                {
                    var selectBaParam = (from C in context.cp_parametros
                                         where C.IdEmpresa == info.IdEmpresa
                                         select C).Count();

                    if (selectBaParam == 0)
                    {
                        cp_parametros addressG = new cp_parametros();
                        addressG.IdEmpresa = info.IdEmpresa;
                        addressG.pa_TipoCbte_OG = info.pa_TipoCbte_OG;
                        addressG.pa_TipoCbte_OG_anulacion = info.pa_TipoCbte_OG_anulacion;
                        addressG.pa_ctacble_deudora = (info.pa_ctacble_deudora == "") ? null : info.pa_ctacble_deudora;
                        addressG.pa_ctacble_iva = (info.pa_ctacble_iva == "") ? null : info.pa_ctacble_iva;
                        addressG.pa_TipoEgrMoviCaja_Conciliacion = info.pa_TipoEgrMoviCaja_Conciliacion;
                        addressG.ip = info.ip;
                        addressG.IdUsuario = info.IdUsuario;
                        addressG.nom_pc = info.nom_pc;
                        addressG.pa_ctacble_Proveedores_default = info.pa_ctacble_Proveedores_default;
                        addressG.pa_TipoCbte_NC = info.pa_TipoCbte_NC;
                        addressG.pa_TipoCbte_NC_anulacion = info.pa_TipoCbte_NC_anulacion;
                        addressG.pa_TipoCbte_ND = info.pa_TipoCbte_ND;
                        addressG.pa_TipoCbte_ND_anulacion = info.pa_TipoCbte_ND_anulacion;
                        addressG.pa_obligaOC = info.pa_obligaOC;
                        addressG.pa_xsd_de_atsSRI = info.pa_xsd_de_atsSRI;
                        addressG.pa_Formulario103_104 = info.pa_Formulario103_104;
                        addressG.pa_IdTipoCbte_x_Anu_Retencion = info.pa_IdTipoCbte_x_Anu_Retencion;
                        addressG.pa_IdTipoCbte_x_Retencion = info.pa_IdTipoCbte_x_Retencion;
                        addressG.pa_TipoCbte_para_conci_x_antcipo = info.pa_TipoCbte_para_conci_x_antcipo;
                        addressG.pa_TipoCbte_para_conci_anulacion_x_antcipo = info.pa_TipoCbte_para_conci_anulacion_x_antcipo;
                        addressG.pa_ruta_descarga_xml_fac_elct = info.pa_ruta_descarga_xml_fac_elct;
                        addressG.pa_ctacble_x_RetIva_default = info.pa_ctacble_x_RetIva_default;
                        addressG.pa_ctacble_x_RetIva_default = info.pa_ctacble_x_RetIva_default;
                        addressG.pa_IdBancoCuenta_default_para_OP = info.pa_IdBancoCuenta_default_para_OP == null ? 0 : info.pa_IdBancoCuenta_default_para_OP;
                        addressG.archivo_diseño_reporte = info.archivo_diseño_reporte;

                        addressG.pa_X_Defecto_la_Retencion_es_cbte_elect = info.pa_X_Defecto_la_Retencion_es_cbte_elect;

                        context.cp_parametros.Add(addressG);
                        context.SaveChanges();
                    }
                    else
                    {
                        var contact = context.cp_parametros.FirstOrDefault(para => para.IdEmpresa == info.IdEmpresa);
                        if (contact != null)
                        {
                            contact.IdEmpresa = info.IdEmpresa;
                            contact.pa_TipoCbte_OG = info.pa_TipoCbte_OG;
                            contact.pa_TipoCbte_OG_anulacion = info.pa_TipoCbte_OG_anulacion;
                            contact.pa_ctacble_deudora = (info.pa_ctacble_deudora == "") ? null : info.pa_ctacble_deudora;
                            contact.pa_ctacble_iva = (info.pa_ctacble_iva == "") ? null : info.pa_ctacble_iva;
                            contact.pa_ctacble_Proveedores_default = info.pa_ctacble_Proveedores_default;
                            contact.pa_TipoEgrMoviCaja_Conciliacion = info.pa_TipoEgrMoviCaja_Conciliacion;
                            contact.pa_TipoCbte_NC = info.pa_TipoCbte_NC;
                            contact.pa_TipoCbte_NC_anulacion = info.pa_TipoCbte_NC_anulacion;
                            contact.pa_TipoCbte_ND = info.pa_TipoCbte_ND;
                            contact.pa_TipoCbte_ND_anulacion = info.pa_TipoCbte_ND_anulacion;
                            contact.pa_obligaOC = info.pa_obligaOC;
                            contact.FechaUltMod = DateTime.Now;
                            contact.IdUsuarioUltMod = info.IdUsuario;
                            contact.pa_xsd_de_atsSRI = info.pa_xsd_de_atsSRI;
                            contact.pa_Formulario103_104 = info.pa_Formulario103_104;
                            contact.pa_IdTipoCbte_x_Anu_Retencion = info.pa_IdTipoCbte_x_Anu_Retencion;
                            contact.pa_IdTipoCbte_x_Retencion = info.pa_IdTipoCbte_x_Retencion;
                            contact.pa_TipoCbte_para_conci_x_antcipo = info.pa_TipoCbte_para_conci_x_antcipo;
                            contact.pa_TipoCbte_para_conci_anulacion_x_antcipo = info.pa_TipoCbte_para_conci_anulacion_x_antcipo;
                            contact.pa_ruta_descarga_xml_fac_elct = info.pa_ruta_descarga_xml_fac_elct;
                            contact.pa_ctacble_x_RetFte_default = info.pa_ctacble_x_RetFte_default;
                            contact.pa_ctacble_x_RetIva_default = info.pa_ctacble_x_RetIva_default;
                            contact.pa_IdBancoCuenta_default_para_OP = info.pa_IdBancoCuenta_default_para_OP == 0 ? null : info.pa_IdBancoCuenta_default_para_OP;
                            contact.archivo_diseño_reporte = info.archivo_diseño_reporte;
                            contact.pa_X_Defecto_la_Retencion_es_cbte_elect = info.pa_X_Defecto_la_Retencion_es_cbte_elect;
                            context.SaveChanges();
                        }
                    }
                }
                return true;
            }
            catch (Exception )
            {
                
                throw ;
            }
        }
        public cp_parametros_Info get_info(int IdEmpresa)
        {
            try
            {
                cp_parametros_Info Cbt = new cp_parametros_Info();
                using (Entities_cuentas_por_pagar Contex = new Entities_cuentas_por_pagar())
                {
                    var selectBaParam = from C in Contex.cp_parametros
                                        where C.IdEmpresa == IdEmpresa
                                        select C;

                    foreach (var item in selectBaParam)
                    {

                        Cbt.pa_TipoCbte_OG = Convert.ToInt32(item.pa_TipoCbte_OG);
                        Cbt.pa_TipoCbte_OG_anulacion = Convert.ToInt32(item.pa_TipoCbte_OG_anulacion);
                        Cbt.pa_ctacble_deudora = item.pa_ctacble_deudora;
                        Cbt.pa_ctacble_iva = item.pa_ctacble_iva;
                        Cbt.pa_TipoEgrMoviCaja_Conciliacion = item.pa_TipoEgrMoviCaja_Conciliacion;
                        Cbt.pa_ctacble_Proveedores_default = item.pa_ctacble_Proveedores_default;
                        Cbt.pa_TipoEgrMoviCaja_Conciliacion = item.pa_TipoEgrMoviCaja_Conciliacion;
                        Cbt.pa_obligaOC = item.pa_obligaOC;
                        Cbt.pa_TipoCbte_NC = item.pa_TipoCbte_NC;
                        Cbt.pa_TipoCbte_NC_anulacion = item.pa_TipoCbte_NC_anulacion;
                        Cbt.pa_TipoCbte_ND = item.pa_TipoCbte_ND;
                        Cbt.pa_TipoCbte_ND_anulacion = item.pa_TipoCbte_ND_anulacion;
                        Cbt.pa_xsd_de_atsSRI = item.pa_xsd_de_atsSRI;
                        Cbt.pa_Formulario103_104 = item.pa_Formulario103_104;
                        Cbt.pa_IdTipoCbte_x_Retencion = item.pa_IdTipoCbte_x_Retencion;
                        Cbt.pa_IdTipoCbte_x_Anu_Retencion = item.pa_IdTipoCbte_x_Anu_Retencion;
                        Cbt.pa_TipoCbte_para_conci_x_antcipo = Convert.ToInt32(item.pa_TipoCbte_para_conci_x_antcipo);
                        Cbt.pa_ruta_descarga_xml_fac_elct = item.pa_ruta_descarga_xml_fac_elct;
                        Cbt.pa_ctacble_x_RetFte_default = item.pa_ctacble_x_RetFte_default;
                        Cbt.pa_ctacble_x_RetIva_default = item.pa_ctacble_x_RetIva_default;
                        Cbt.pa_IdBancoCuenta_default_para_OP = item.pa_IdBancoCuenta_default_para_OP;
                        Cbt.archivo_diseño_reporte = item.archivo_diseño_reporte;
                        Cbt.pa_X_Defecto_la_Retencion_es_cbte_elect = item.pa_X_Defecto_la_Retencion_es_cbte_elect;
                        Cbt.pa_TipoCbte_para_conci_anulacion_x_antcipo = item.pa_TipoCbte_para_conci_anulacion_x_antcipo;
                        Cbt.pa_X_Defecto_la_Retencion_es_cbte_elect = item.pa_X_Defecto_la_Retencion_es_cbte_elect;

                        Cbt.IdEmpresa = IdEmpresa;

                    }
                }
                return (Cbt);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public List<cp_parametros_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<cp_parametros_Info> lista = new List<cp_parametros_Info>();
                using (Entities_cuentas_por_pagar Contex = new Entities_cuentas_por_pagar())
                {
                    lista = (from q in Contex.cp_parametros
                             where q.IdEmpresa == IdEmpresa
                             select new cp_parametros_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 pa_TipoCbte_OG = q.pa_TipoCbte_OG,
                                 pa_TipoCbte_OG_anulacion = q.pa_TipoCbte_OG_anulacion,
                                 pa_ctacble_deudora = q.pa_ctacble_deudora,
                                 pa_ctacble_iva = q.pa_ctacble_iva,
                                 pa_TipoEgrMoviCaja_Conciliacion = q.pa_TipoEgrMoviCaja_Conciliacion,
                                 pa_ctacble_Proveedores_default = q.pa_ctacble_Proveedores_default,
                                 pa_obligaOC = q.pa_obligaOC,
                                 pa_TipoCbte_NC = q.pa_TipoCbte_NC,
                                 pa_TipoCbte_NC_anulacion = q.pa_TipoCbte_NC_anulacion,
                                 pa_TipoCbte_ND = q.pa_TipoCbte_ND,
                                 pa_TipoCbte_ND_anulacion = q.pa_TipoCbte_ND_anulacion,
                                 pa_xsd_de_atsSRI = q.pa_xsd_de_atsSRI,
                                 pa_Formulario103_104 = q.pa_Formulario103_104,
                                 pa_IdTipoCbte_x_Retencion = q.pa_IdTipoCbte_x_Retencion,
                                 pa_IdTipoCbte_x_Anu_Retencion = q.pa_IdTipoCbte_x_Anu_Retencion,
                                 pa_TipoCbte_para_conci_x_antcipo = q.pa_TipoCbte_para_conci_x_antcipo,
                                 pa_ruta_descarga_xml_fac_elct = q.pa_ruta_descarga_xml_fac_elct,
                                 pa_ctacble_x_RetFte_default = q.pa_ctacble_x_RetFte_default,
                                 pa_ctacble_x_RetIva_default = q.pa_ctacble_x_RetIva_default,
                                 pa_IdBancoCuenta_default_para_OP = q.pa_IdBancoCuenta_default_para_OP,
                                 archivo_diseño_reporte = q.archivo_diseño_reporte,
                                 pa_X_Defecto_la_Retencion_es_cbte_elect = q.pa_X_Defecto_la_Retencion_es_cbte_elect,
                                 pa_TipoCbte_para_conci_anulacion_x_antcipo = q.pa_TipoCbte_para_conci_anulacion_x_antcipo,
                                 descripcion="Parametrizacion de cuenta por pagar"
                                 
                             }).ToList();
                         }
                return lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }

}
