using Core.Erp.Info.Presupuesto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Presupuesto
{
    public class pre_Grupo_x_seg_usuario_Data
    {
        public List<pre_Grupo_x_seg_usuario_Info> GetList(int IdEmpresa, int IdGrupo)
        {
            try
            {
                List<pre_Grupo_x_seg_usuario_Info> Lista = new List<pre_Grupo_x_seg_usuario_Info>();

                using (Entities_presupuesto db = new Entities_presupuesto())
                {
                    Lista = db.vwpre_Grupo.Where(q => q.IdEmpresa == IdEmpresa && q.IdGrupo == IdGrupo).Select(q => new pre_Grupo_x_seg_usuario_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdGrupo = q.IdGrupo,
                        Secuencia = q.Secuencia,
                        IdUsuario = q.IdUsuario,
                        Nombre = q.Nombre,
                        AsignaCuentas = q.AsignaCuentas
                    }).ToList();

                    return Lista;
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
