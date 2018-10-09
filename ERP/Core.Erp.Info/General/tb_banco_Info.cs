using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.General
{
    public class tb_banco_Info
    {
        [Key]
        public int IdBanco { get; set; }

        [Required(ErrorMessage = "El campo descripción es obligatorio")]
        [StringLength(100, MinimumLength = 1, ErrorMessage = "el campo descripción debe tener mínimo 1 caracter y máximo 100")]
        public string ba_descripcion { get; set; }
        public string Estado { get; set; }
        public bool EstadoBool { get; set; }
        [Required(ErrorMessage = "El campo código legal es obligatorio")]
        [StringLength(10, MinimumLength = 1, ErrorMessage = "el campo código debe tener mínimo 1 caracter y máximo 10")]
        public string CodigoLegal { get; set; }
        public bool TieneFormatoTransferencia { get; set; }
    }
}
