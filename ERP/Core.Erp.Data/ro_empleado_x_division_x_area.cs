//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class ro_empleado_x_division_x_area
    {
        public int IdEmpresa { get; set; }
        public decimal IdEmpleado { get; set; }
        public int Secuencia { get; set; }
        public int IDividion { get; set; }
        public int IdArea { get; set; }
        public double Porcentaje { get; set; }
        public string Observacion { get; set; }
    
        public virtual ro_area ro_area { get; set; }
        public virtual ro_empleado ro_empleado { get; set; }
    }
}