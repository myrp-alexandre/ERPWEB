using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Contabilidad;
namespace Core.Erp.Info.CuentasPorPagar
{
  public  class cp_orden_giro_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdCbteCble_Ogiro { get; set; }
        public int IdTipoCbte_Ogiro { get; set; }
        public string IdOrden_giro_Tipo { get; set; }
        public decimal IdProveedor { get; set; }
        public System.DateTime co_fechaOg { get; set; }
        [RegularExpression(@"\d{3}-\d{3}", ErrorMessage = "Serie no valida")]
        public string co_serie { get; set; }
        public string co_factura { get; set; }
        public System.DateTime co_FechaFactura { get; set; }
        public Nullable<System.DateTime> co_FechaContabilizacion { get; set; }
        public System.DateTime co_FechaFactura_vct { get; set; }
        public int co_plazo { get; set; }
        public string co_observacion { get; set; }
        public double co_subtotal_iva { get; set; }
        public double co_subtotal_siniva { get; set; }
        public double co_baseImponible { get; set; }
        public double co_Por_iva { get; set; }
        public double co_valoriva { get; set; }
        public Nullable<int> IdCod_ICE { get; set; }
        public double co_Ice_base { get; set; }
        public double co_Ice_por { get; set; }
        public double co_Ice_valor { get; set; }
        public double co_Serv_por { get; set; }
        public double co_Serv_valor { get; set; }
        public double co_OtroValor_a_descontar { get; set; }
        public double co_OtroValor_a_Sumar { get; set; }
        public double co_BaseSeguro { get; set; }
        public double co_total { get; set; }
        public double co_valorpagar { get; set; }
        public string co_vaCoa { get; set; }
        public Nullable<int> IdIden_credito { get; set; }
        public Nullable<int> IdCod_101 { get; set; }
        public Nullable<decimal> IdTipoFlujo { get; set; }
        public string IdTipoServicio { get; set; }
        public string IdCtaCble_Gasto { get; set; }
        public string IdCtaCble_IVA { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string Estado { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public string MotivoAnu { get; set; }
        public string nom_pc { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string ip { get; set; }
        public string co_retencionManual { get; set; }
        public Nullable<decimal> IdCbteCble_Anulacion { get; set; }
        public Nullable<int> IdTipoCbte_Anulacion { get; set; }
        public string IdCentroCosto { get; set; }
        public Nullable<int> IdSucursal { get; set; }
        public string PagoLocExt { get; set; }
        public string PaisPago { get; set; }
        public string ConvenioTributacion { get; set; }
        public string PagoSujetoRetencion { get; set; }
        public Nullable<double> BseImpNoObjDeIva { get; set; }
        public Nullable<System.DateTime> fecha_autorizacion { get; set; }
        public string Num_Autorizacion { get; set; }
        public string Num_Autorizacion_Imprenta { get; set; }
        public double co_propina { get; set; }
        public double co_IRBPNR { get; set; }
        public Nullable<bool> es_retencion_electronica { get; set; }
        public Nullable<bool> cp_es_comprobante_electronico { get; set; }
        public string Tipodoc_a_Modificar { get; set; }
        public string estable_a_Modificar { get; set; }
        public string ptoEmi_a_Modificar { get; set; }
        public string num_docu_Modificar { get; set; }
        public string aut_doc_Modificar { get; set; }
        public Nullable<int> IdTipoMovi { get; set; }
        public cp_cuotas_x_doc_Info info_cuota { get; set; }
        public ct_cbtecble_Info info_comrobante { get; set; }
        public cp_proveedor_Info info_proveedor { get; set; }
        public string Descripcion { get; set; }
        public string Tipo_Vcto { get; set; }
        public int Dias_Vencidos { get; set; }
        public double Total_Pagado { get; set; }
        public Nullable<double> Saldo_OG { get; set; }

        public cp_orden_giro_Info ()
        {
            info_cuota = new cp_cuotas_x_doc_Info();
            info_comrobante = new ct_cbtecble_Info();
            info_proveedor = new cp_proveedor_Info();
        }
    }
}
