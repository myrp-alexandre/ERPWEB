//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class ro_participacion_utilidad_empleado
    {
        public int IdEmpresa { get; set; }
        public int IdUtilidad { get; set; }
        public decimal IdEmpleado { get; set; }
        public double DiasTrabajados { get; set; }
        public double CargasFamiliares { get; set; }
        public double ValorIndividual { get; set; }
        public double ValorCargaFamiliar { get; set; }
        public double ValorExedenteIESS { get; set; }
        public double ValorTotal { get; set; }
        public string Observacion { get; set; }
    
        public virtual ro_participacion_utilidad ro_participacion_utilidad { get; set; }
        public virtual ro_empleado ro_empleado { get; set; }
    }
}
