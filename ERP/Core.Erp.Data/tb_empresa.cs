//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class tb_empresa
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tb_empresa()
        {
            this.tb_sucursal = new HashSet<tb_sucursal>();
            this.tb_sis_reporte_x_seg_usuario = new HashSet<tb_sis_reporte_x_seg_usuario>();
        }
    
        public int IdEmpresa { get; set; }
        public string codigo { get; set; }
        public string em_nombre { get; set; }
        public string RazonSocial { get; set; }
        public string NombreComercial { get; set; }
        public string ContribuyenteEspecial { get; set; }
        public string ObligadoAllevarConta { get; set; }
        public string em_ruc { get; set; }
        public string em_gerente { get; set; }
        public string em_contador { get; set; }
        public string em_rucContador { get; set; }
        public string em_telefonos { get; set; }
        public string em_fax { get; set; }
        public Nullable<int> em_notificacion { get; set; }
        public string em_direccion { get; set; }
        public string em_tel_int { get; set; }
        public byte[] em_logo { get; set; }
        public byte[] em_fondo { get; set; }
        public System.DateTime em_fechaInicioContable { get; set; }
        public string Estado { get; set; }
        public Nullable<System.DateTime> em_fechaInicioActividad { get; set; }
        public string cod_entidad_dinardap { get; set; }
        public string em_Email { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_sucursal> tb_sucursal { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_sis_reporte_x_seg_usuario> tb_sis_reporte_x_seg_usuario { get; set; }
    }
}
