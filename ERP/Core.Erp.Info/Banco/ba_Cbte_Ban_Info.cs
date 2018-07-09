using System;

namespace Core.Erp.Info.Banco
{
    public class ba_Cbte_Ban_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdCbteCble { get; set; }
        public int IdTipocbte { get; set; }
        public string Cod_Cbtecble { get; set; }
        public int IdPeriodo { get; set; }
        public int IdBanco { get; set; }
        public System.DateTime cb_Fecha { get; set; }
        public string cb_Observacion { get; set; }
        public double cb_Valor { get; set; }
        public string cb_Cheque { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuario_Anu { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public string Estado { get; set; }
        public string MotivoAnulacion { get; set; }
        public Nullable<decimal> IdPersona_Girado_a { get; set; }
        public string cb_giradoA { get; set; }
        public string cb_ciudadChq { get; set; }
        public Nullable<decimal> IdTipoFlujo { get; set; }
        public Nullable<int> IdTipoNota { get; set; }
        public string ValorEnLetras { get; set; }
        public Nullable<int> IdSucursal { get; set; }
        public string IdEstado_Cbte_Ban_cat { get; set; }
        public string IdEstado_Preaviso_ch_cat { get; set; }
        public string IdEstado_cheque_cat { get; set; }
        public Nullable<decimal> IdPersona { get; set; }
        public Nullable<decimal> IdEntidad { get; set; }
        public string IdTipo_Persona { get; set; }
    }
}
