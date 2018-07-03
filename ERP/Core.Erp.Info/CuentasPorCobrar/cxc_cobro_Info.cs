using System;
using System.ComponentModel.DataAnnotations;

namespace Core.Erp.Info.CuentasPorCobrar
{
    public class cxc_cobro_Info
    {
        

        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public decimal IdCobro { get; set; }
        public Nullable<decimal> IdCobro_a_aplicar { get; set; }
        public string cr_Codigo { get; set; }
        public string IdCobro_tipo { get; set; }
        [Range(1,999999,ErrorMessage ="El campo cliente es obligatorio")]
        [Required(ErrorMessage = "El campo cliente es obligatorio")]
        public decimal IdCliente { get; set; }
        public double cr_TotalCobro { get; set; }
        public System.DateTime cr_fecha { get; set; }
        public System.DateTime cr_fechaDocu { get; set; }
        public System.DateTime cr_fechaCobro { get; set; }
        public string cr_observacion { get; set; }
        public string cr_Banco { get; set; }
        public string cr_cuenta { get; set; }
        public string cr_NumDocumento { get; set; }
        public string cr_Tarjeta { get; set; }
        public string cr_propietarioCta { get; set; }
        public string cr_estado { get; set; }
        public Nullable<decimal> cr_recibo { get; set; }
        public string cr_es_anticipo { get; set; }
        public Nullable<int> IdBanco { get; set; }
        public int IdCaja { get; set; }
        public string MotiAnula { get; set; }
        public Nullable<int> IdTipoNotaCredito { get; set; }

        #region Campos de auditoria
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        #endregion
        
        #region Campos que no existen en la tabla
        public string pe_nombreCompleto { get; set; }
        public string tc_descripcion { get; set; }
        public string Su_Descripcion { get; set; }
        #endregion
    }
}
