using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_contrato_Info
    {
        public int IdEmpresa { get; set; }
        [Required(ErrorMessage = "El campo empleado es obligatorio")]
        public decimal IdEmpleado { get; set; }
        public decimal IdContrato { get; set; }
        [Required(ErrorMessage = "El campo tipo contrato es obligatorio")]
        public string IdContrato_Tipo { get; set; }
        [Required(ErrorMessage = "El campo número documento es obligatorio")]
        [StringLength(25,  ErrorMessage = "La descripción debe tener mínimo 4 caracteres y máximo 200")]
        public string NumDocumento { get; set; }
        [Required(ErrorMessage = "El campo fecha inicio es obligatorio")]
        [DataType(DataType.Date)]
        public System.DateTime FechaInicio { get; set; }
        [DataType(DataType.Date)]
        public System.DateTime FechaFin { get; set; }
        public string Estado { get; set; }
        public bool EstadoBool { get; set; }
        [Required(ErrorMessage = "El campo observación es obligatorio")]
        [StringLength(200, MinimumLength = 4, ErrorMessage = "La descripción debe tener mínimo 4 caracteres y máximo 200")]
        public string Observacion { get; set; }
        [Required(ErrorMessage = "El campo nómina es obligatorio")]
        public Nullable<int> IdNomina { get; set; }
        [Required(ErrorMessage = "El campo sueldo es obligatorio")]
        public Nullable<double> Sueldo { get; set; }
        public string MotiAnula { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> FechaHoraAnul { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        [Required(ErrorMessage = "El campo estado contrato es obligatorio")]
        public string EstadoContrato { get; set; }
        public string IdUsuario { get; set; }
        public string Empleado { get; set; }
        public string Contrato { get; set; }

        public Nullable<System.DateTime> em_fechaSalida { get; set; }



    }
}
