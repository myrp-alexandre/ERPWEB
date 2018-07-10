using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_Talonario_cheques_x_banco_Data
    {
        public List<ba_Talonario_cheques_x_banco_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ba_Talonario_cheques_x_banco_Info> Lista;
                using (Entities_banco Context = new Entities_banco())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.ba_Talonario_cheques_x_banco
                                 where q.IdEmpresa == IdEmpresa
                                 select new ba_Talonario_cheques_x_banco_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdBanco = q.IdBanco,
                                     Num_cheque = q.Num_cheque,
                                     Usado = q.Usado,
                                     Estado = q.Estado,
                                     secuencia = q.secuencia,
                                     IdCbteCble_cbtecble_Usado = q.IdCbteCble_cbtecble_Usado,
                                     IdEmpresa_cbtecble_Usado = q.IdEmpresa_cbtecble_Usado,
                                     IdTipoCbte_cbtecble_Usado = q.IdTipoCbte_cbtecble_Usado,
                                     Fecha_uso= q.Fecha_uso

                                     
                                 }).ToList();
                    else
                        Lista = (from q in Context.ba_Talonario_cheques_x_banco
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new ba_Talonario_cheques_x_banco_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdBanco = q.IdBanco,
                                     Num_cheque = q.Num_cheque,
                                     Usado = q.Usado,
                                     Estado = q.Estado,
                                     secuencia = q.secuencia,
                                     IdCbteCble_cbtecble_Usado = q.IdCbteCble_cbtecble_Usado,
                                     IdEmpresa_cbtecble_Usado = q.IdEmpresa_cbtecble_Usado,
                                     IdTipoCbte_cbtecble_Usado = q.IdTipoCbte_cbtecble_Usado,
                                     Fecha_uso = q.Fecha_uso
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ba_Talonario_cheques_x_banco_Info get_info(int IdEmpresa, int IdBanco, string Num_cheque)
        {
            try
            {
                ba_Talonario_cheques_x_banco_Info info = new ba_Talonario_cheques_x_banco_Info();
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Talonario_cheques_x_banco Entity = Context.ba_Talonario_cheques_x_banco.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdBanco == IdBanco && q.Num_cheque == Num_cheque);
                    if (Entity == null) return null;
                    info = new ba_Talonario_cheques_x_banco_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdBanco = Entity.IdBanco,
                        IdCbteCble_cbtecble_Usado = Entity.IdCbteCble_cbtecble_Usado,
                        IdEmpresa_cbtecble_Usado = Entity.IdEmpresa_cbtecble_Usado,
                        IdTipoCbte_cbtecble_Usado = Entity.IdTipoCbte_cbtecble_Usado,
                        Estado = Entity.Estado,
                        Num_cheque = Entity.Num_cheque,
                        secuencia = Entity.secuencia,
                        Usado = Entity.Usado,
                        Fecha_uso = Entity.Fecha_uso
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public string get_id(int IdEmpresa)
        {
            try
            {
                string ID = "";
                using (Entities_banco Context = new Entities_banco())
                {
                    var lst = from q in Context.ba_Talonario_cheques_x_banco
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = (Convert.ToInt32(lst.Max(q => q.Num_cheque)) + 1).ToString("00000");
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ba_Talonario_cheques_x_banco_Info info)
        {
            try
            {
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Talonario_cheques_x_banco Entity = new ba_Talonario_cheques_x_banco
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdBanco = info.IdBanco=Convert.ToInt32(get_id(info.IdEmpresa)),
                        Num_cheque = info.Num_cheque,
                        Usado = info.Usado,
                        Estado = info.Estado_bool == true ? "S" : "N",
                        IdCbteCble_cbtecble_Usado = info.IdCbteCble_cbtecble_Usado,
                        IdEmpresa_cbtecble_Usado = info.IdEmpresa_cbtecble_Usado,
                        IdTipoCbte_cbtecble_Usado = info.IdTipoCbte_cbtecble_Usado,
                        secuencia = info.secuencia,
                        Fecha_uso = info.Fecha_uso
                    };
                    Context.ba_Talonario_cheques_x_banco.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(ba_Talonario_cheques_x_banco_Info info)
        {
            try
            {
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Talonario_cheques_x_banco Entity = Context.ba_Talonario_cheques_x_banco.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdBanco == info.IdBanco && q.Num_cheque == info.Num_cheque);
                    if (Entity == null) return false;

                    Entity.Usado = info.Usado;
                    Entity.Estado = info.Estado_bool == true ? "S" : "N";

                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(ba_Talonario_cheques_x_banco_Info info)
        {
            try
            {
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Talonario_cheques_x_banco Entity = Context.ba_Talonario_cheques_x_banco.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdBanco == info.IdBanco && q.Num_cheque == info.Num_cheque);
                    if (Entity == null) return false;
                    
                    Entity.Estado = info.Estado ="I";

                    Entity.IdUsuario_Anu = info.IdUsuario_Anu;
                    Entity.FechaAnulacion = DateTime.Now;
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
