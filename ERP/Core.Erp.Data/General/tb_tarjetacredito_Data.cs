using Core.Erp.Info.General;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
    public class tb_TarjetaCredito_Data
    {
        public List<tb_TarjetaCredito_Info> GetList(bool MostrarAnulado)
        {
            try
            {
                List<tb_TarjetaCredito_Info> Lista=new List<tb_TarjetaCredito_Info>();
                
                using (Entities_general db = new Entities_general())
                {
                    if (MostrarAnulado == false)
                    {
                        Lista = db.tb_TarjetaCredito.Where(q => q.Estado == true).Select(q => new tb_TarjetaCredito_Info
                        {
                            IdTarjeta = q.IdTarjeta,
                            NombreTarjeta = q.NombreTarjeta,
                            Estado = q.Estado
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.tb_TarjetaCredito.Select(q => new tb_TarjetaCredito_Info
                        {
                            IdTarjeta = q.IdTarjeta,
                            NombreTarjeta = q.NombreTarjeta,
                            Estado = q.Estado
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

        public tb_TarjetaCredito_Info GetInfo(int IdTarjeta)
        {
            try
            {
                tb_TarjetaCredito_Info info = new tb_TarjetaCredito_Info();

                using (Entities_general Context = new Entities_general())
                {
                    tb_TarjetaCredito Entity = Context.tb_TarjetaCredito.FirstOrDefault(q => q.IdTarjeta == IdTarjeta);
                    if (Entity == null) return null;
                    info = new tb_TarjetaCredito_Info
                    {
                        IdTarjeta = Entity.IdTarjeta,
                        NombreTarjeta = Entity.NombreTarjeta, 
                        Estado = Entity.Estado                    
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public int get_id()
        {

            try
            {
                int ID = 1;
                using (Entities_general db = new Entities_general())
                {
                    var Lista = db.tb_TarjetaCredito.Select(q => q.IdTarjeta);

                    if (Lista.Count() > 0)
                        ID = Lista.Max() + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool GuardarBD(tb_TarjetaCredito_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    db.tb_TarjetaCredito.Add(new tb_TarjetaCredito
                    {
                        IdTarjeta = get_id(),
                        NombreTarjeta = info.NombreTarjeta,
                        Estado = info.Estado=true,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now                       
                    });

                    db.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool ModificarBD(tb_TarjetaCredito_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    tb_TarjetaCredito entity = db.tb_TarjetaCredito.Where(q => q.IdTarjeta == info.IdTarjeta).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.NombreTarjeta = info.NombreTarjeta;
                    entity.IdUsuarioUltMod = info.IdUsuario;
                    entity.Fecha_UltMod = DateTime.Now;
                        
                    db.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool AnularBD(tb_TarjetaCredito_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    tb_TarjetaCredito entity = db.tb_TarjetaCredito.Where(q => q.IdTarjeta == info.IdTarjeta).FirstOrDefault();

                    if (entity == null)
                    {
                        return false;
                    }

                    entity.Estado = info.Estado;
                    entity.IdUsuarioUltAnu = info.IdUsuario;
                    entity.Fecha_UltAnu = DateTime.Now;

                    db.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        #region metodo baja demanda

        public List<tb_TarjetaCredito_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            var skip = args.BeginIndex;
            var take = args.EndIndex - args.BeginIndex + 1;
            List<tb_TarjetaCredito_Info> Lista = new List<tb_TarjetaCredito_Info>();
            Lista = get_list(skip, take, args.Filter);

            return Lista;
        }

        public List<tb_TarjetaCredito_Info> get_list(int skip, int take, string filter)
        {
            try
            {
                List<tb_TarjetaCredito_Info> Lista;

                using (Entities_general Context = new Entities_general())
                {
                    Lista = (from p in Context.tb_TarjetaCredito
                             where (p.IdTarjeta.ToString() + " " + p.NombreTarjeta).Contains(filter)
                             select new tb_TarjetaCredito_Info
                             {
                                IdTarjeta = p.IdTarjeta,
                                NombreTarjeta = p.NombreTarjeta,
                                Estado = p.Estado
                             })
                                .OrderBy(p => p.IdTarjeta)
                                .Skip(skip)
                                .Take(take)
                                .ToList();

                }
                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public tb_TarjetaCredito_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            decimal id;
            if (args.Value == null || !decimal.TryParse(args.Value.ToString(), out id))
                return null;
            return get_info_demanda(Convert.ToInt32(args.Value));
        }

        public tb_TarjetaCredito_Info get_info_demanda(int IdTarjetaCredito)
        {
            try
            {
                tb_TarjetaCredito_Info info = new tb_TarjetaCredito_Info();
                using (Entities_general Context = new Entities_general())
                {
                    info = (from q in Context.tb_TarjetaCredito
                            where q.IdTarjeta == IdTarjetaCredito
                            select new tb_TarjetaCredito_Info
                            {
                                IdTarjeta = q.IdTarjeta,
                                NombreTarjeta = q.NombreTarjeta,
                                Estado = q.Estado
                            }).FirstOrDefault();
                }

                return info;

            }
            catch (Exception)
            {

                throw;
            }
        }       
        #endregion
    }
}
