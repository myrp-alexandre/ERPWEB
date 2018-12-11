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

        public pre_Grupo_x_seg_usuario_Info GetInfoPermiso(int IdEmpresa, string IdUsuario)
        {
            try
            {
                pre_Grupo_x_seg_usuario_Info info = new pre_Grupo_x_seg_usuario_Info();
                using (Entities_presupuesto Context = new Entities_presupuesto())
                {
                    pre_Grupo_x_seg_usuario Entity = Context.pre_Grupo_x_seg_usuario.Where(q => q.IdEmpresa == IdEmpresa && q.IdUsuario == IdUsuario && q.AsignaCuentas == true && q.pre_Grupo.Estado == true).FirstOrDefault();

                    if (Entity == null) return null;
                    info = new pre_Grupo_x_seg_usuario_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdGrupo = Entity.IdGrupo,
                        Secuencia = Entity.Secuencia,
                        IdUsuario = Entity.IdUsuario,
                        AsignaCuentas = Entity.AsignaCuentas
                    };
                }

                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }       
    }
}
