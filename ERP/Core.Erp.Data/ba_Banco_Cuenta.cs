//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class ba_Banco_Cuenta
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ba_Banco_Cuenta()
        {
            this.ba_Talonario_cheques_x_banco = new HashSet<ba_Talonario_cheques_x_banco>();
            this.ba_Cbte_Ban = new HashSet<ba_Cbte_Ban>();
        }
    
        public int IdEmpresa { get; set; }
        public int IdBanco { get; set; }
        public string ba_descripcion { get; set; }
        public string ba_Tipo { get; set; }
        public string ba_Num_Cuenta { get; set; }
        public int ba_num_digito_cheq { get; set; }
        public string IdCtaCble { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        public string Estado { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string MotiAnula { get; set; }
        public byte[] Reporte { get; set; }
        public byte[] ReporteSolo_Cheque { get; set; }
        public Nullable<bool> MostrarVistaPreviaCheque { get; set; }
        public Nullable<bool> Imprimir_Solo_el_cheque { get; set; }
        public Nullable<int> IdBanco_Financiero { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ba_Talonario_cheques_x_banco> ba_Talonario_cheques_x_banco { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ba_Cbte_Ban> ba_Cbte_Ban { get; set; }
    }
}
