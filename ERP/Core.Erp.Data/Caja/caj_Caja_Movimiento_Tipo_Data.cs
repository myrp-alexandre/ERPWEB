using Core.Erp.Info.Caja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Caja
{
    public class caj_Caja_Movimiento_Tipo_Data
    {
        public List<caj_Caja_Movimiento_Tipo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<caj_Caja_Movimiento_Tipo_Info> Lista;
                using (Entities_caja Context = new Entities_caja())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.caj_Caja_Movimiento_Tipo
                             where q.IdEmpresa == IdEmpresa
                             orderby q.tm_Signo
                             select new caj_Caja_Movimiento_Tipo_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdTipoMovi = q.IdTipoMovi,
                                 Estado = q.Estado,
                                 tm_descripcion = q.tm_descripcion,
                                 SeDeposita = q.SeDeposita,
                                 tm_Signo = q.tm_Signo,
                                 IdTipoMovi_grupo = q.IdTipoMovi_grupo,
                                 IdCtaCble = q.IdCtaCble,

                                 EstadoBool = q.Estado == "A" ? true : false
                             }).ToList();
                    else
                        Lista = (from q in Context.caj_Caja_Movimiento_Tipo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 orderby q.tm_Signo
                                 select new caj_Caja_Movimiento_Tipo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdTipoMovi = q.IdTipoMovi,
                                     Estado = q.Estado,
                                     tm_descripcion = q.tm_descripcion,
                                     SeDeposita = q.SeDeposita,
                                     tm_Signo = q.tm_Signo,
                                     IdTipoMovi_grupo = q.IdTipoMovi_grupo,
                                     IdCtaCble = q.IdCtaCble,

                                     EstadoBool = q.Estado == "A" ? true : false

                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        
        public List<caj_Caja_Movimiento_Tipo_Info> get_list(int IdEmpresa, string signo, bool mostrar_anulados, bool mostrar_sin_ctaCble)
        {
            try
            {
                List<caj_Caja_Movimiento_Tipo_Info> Lista;
                using (Entities_caja Context = new Entities_caja())
                {
                    if (mostrar_anulados)
                    {
                        if(mostrar_sin_ctaCble)
                        Lista = (from q in Context.caj_Caja_Movimiento_Tipo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.tm_Signo == signo
                                 select new caj_Caja_Movimiento_Tipo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdTipoMovi = q.IdTipoMovi,
                                     Estado = q.Estado,
                                     tm_descripcion = q.tm_descripcion,
                                     SeDeposita = q.SeDeposita,
                                     tm_Signo = q.tm_Signo,
                                     IdTipoMovi_grupo = q.IdTipoMovi_grupo,
                                     IdCtaCble = q.IdCtaCble
                                 }).ToList();
                        else
                            Lista = (from q in Context.caj_Caja_Movimiento_Tipo
                                     where q.IdEmpresa == IdEmpresa
                                     && q.tm_Signo == signo
                                     && q.IdCtaCble != null
                                     select new caj_Caja_Movimiento_Tipo_Info
                                     {
                                         IdEmpresa = q.IdEmpresa,
                                         IdTipoMovi = q.IdTipoMovi,
                                         Estado = q.Estado,
                                         tm_descripcion = q.tm_descripcion,
                                         SeDeposita = q.SeDeposita,
                                         tm_Signo = q.tm_Signo,
                                         IdTipoMovi_grupo = q.IdTipoMovi_grupo,
                                         IdCtaCble = q.IdCtaCble
                                     }).ToList();
                    }
                    else
                    {
                        if (mostrar_sin_ctaCble)
                            Lista = (from q in Context.caj_Caja_Movimiento_Tipo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.tm_Signo == signo
                                 && q.Estado == "A"
                                 select new caj_Caja_Movimiento_Tipo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdTipoMovi = q.IdTipoMovi,
                                     Estado = q.Estado,
                                     tm_descripcion = q.tm_descripcion,
                                     SeDeposita = q.SeDeposita,
                                     tm_Signo = q.tm_Signo,
                                     IdTipoMovi_grupo = q.IdTipoMovi_grupo,
                                     IdCtaCble = q.IdCtaCble,

                                 }).ToList();
                        else
                            Lista = (from q in Context.caj_Caja_Movimiento_Tipo
                                     where q.IdEmpresa == IdEmpresa
                                     && q.tm_Signo == signo
                                     && q.Estado == "A"
                                     && q.IdCtaCble != null
                                     select new caj_Caja_Movimiento_Tipo_Info
                                     {
                                         IdEmpresa = q.IdEmpresa,
                                         IdTipoMovi = q.IdTipoMovi,
                                         Estado = q.Estado,
                                         tm_descripcion = q.tm_descripcion,
                                         SeDeposita = q.SeDeposita,
                                         tm_Signo = q.tm_Signo,
                                         IdTipoMovi_grupo = q.IdTipoMovi_grupo,
                                         IdCtaCble = q.IdCtaCble,

                                     }).ToList();
                    }
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public caj_Caja_Movimiento_Tipo_Info get_info(int IdEmpresa, int IdTipoMovi)
        {
            try
            {
                caj_Caja_Movimiento_Tipo_Info info = new caj_Caja_Movimiento_Tipo_Info();
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento_Tipo Entity = Context.caj_Caja_Movimiento_Tipo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdTipoMovi == IdTipoMovi);
                    if (Entity == null) return null;
                    info = new caj_Caja_Movimiento_Tipo_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdTipoMovi = Entity.IdTipoMovi,
                        Estado = Entity.Estado,
                        tm_descripcion = Entity.tm_descripcion,
                        SeDeposita = Entity.SeDeposita,
                        tm_Signo = Entity.tm_Signo,
                        IdCtaCble = Entity.IdCtaCble,
                        IdTipoMovi_grupo = Entity.IdTipoMovi_grupo

                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int  get_id(int IdEmpresa)
        {
            try
            {
                int ID = 1;
                using (Entities_caja Context = new Entities_caja())
                {
                    var lst = from q in Context.caj_Caja_Movimiento_Tipo
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdTipoMovi) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(caj_Caja_Movimiento_Tipo_Info info)
        {
            try
            {
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento_Tipo Entity = new caj_Caja_Movimiento_Tipo
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdTipoMovi = info.IdTipoMovi=get_id(info.IdEmpresa),
                        Estado = info.Estado="A",
                        tm_descripcion = info.tm_descripcion,
                        SeDeposita = info.SeDeposita,
                        tm_Signo = info.tm_Signo,
                        IdTipoMovi_grupo = info.IdTipoMovi_grupo,
                        IdCtaCble = info.IdCtaCble,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now

                    };
                    Context.caj_Caja_Movimiento_Tipo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(caj_Caja_Movimiento_Tipo_Info info)
        {
            try
            {
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento_Tipo Entity = Context.caj_Caja_Movimiento_Tipo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdTipoMovi == info.IdTipoMovi);
                    if (Entity == null) return false;

                    Entity.IdTipoMovi_grupo = info.IdTipoMovi_grupo;
                    Entity.tm_descripcion = info.tm_descripcion;
                    Entity.SeDeposita = info.SeDeposita;
                    Entity.tm_Signo = info.tm_Signo;
                    Entity.IdCtaCble = info.IdCtaCble;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = info.Fecha_UltMod;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(caj_Caja_Movimiento_Tipo_Info info)
        {
            try
            {
                using (Entities_caja Context = new Entities_caja())
                {
                    caj_Caja_Movimiento_Tipo Entity = Context.caj_Caja_Movimiento_Tipo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdTipoMovi == info.IdTipoMovi);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado="I";


                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
